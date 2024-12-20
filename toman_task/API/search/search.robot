*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://api.divar.ir/v8
${ENDPOINT}    /postlist/w/search

&{HEADERS}    
...    accept=application/json, text/plain, */*
...    content-type=application/json
...    origin=https://divar.ir
...    referer=https://divar.ir/
...    x-render-type=CSR
...    x-standard-divar-error=true

# ساختار داخلی sort
&{SORT_VALUE}=              value=sort_date
&{SORT_STR}=                str=&{SORT_VALUE}
&{SORT}=                    sort=&{SORT_STR}
&{ADDITIONAL_FORM_DATA}=    data=&{SORT}

# ساختار داخلی category
&{CATEGORY_VALUE}=          value=real-estate
&{CATEGORY_STR}=            str=&{CATEGORY_VALUE}
&{DATA_FORM}=               category=&{CATEGORY_STR}

# form_data
&{FORM_DATA}=               data=&{DATA_FORM}

# server_payload
&{SERVER_PAYLOAD}=          @type=type.googleapis.com/widgets.SearchData.ServerPayload    additional_form_data=&{ADDITIONAL_FORM_DATA}

# search_data
&{SEARCH_DATA}=             form_data=&{FORM_DATA}    server_payload=&{SERVER_PAYLOAD}

# تعریف city_ids به صورت یک لیست Robot Framework
@{CITY_IDS}=    Create List    671

# کل بدنه - توجه: اکنون city_ids=@{CITY_IDS} و source_view="CATEGORY"
&{VALID_BODY}              city_ids=@{CITY_IDS}    source_view="CATEGORY"    search_data=&{SEARCH_DATA}


*** Test Cases ***
Send Valid Request
    [Documentation]    ارسال درخواست معتبر و انتظار دریافت کد 200
    Create Session    divar    ${BASE_URL}
    ${response}=    POST On Session    divar    ${ENDPOINT}    headers=&{HEADERS}    json=&{VALID_BODY}
    Should Be Equal As Integers    ${response.status_code}    200



Send Invalid City Id
    [Documentation]    ارسال با city_ids نامعتبر
    Create Session    divar    ${BASE_URL}
    &{INVALID_BODY}=    Create Dictionary    city_ids=["00"]    source_view="CATEGORY"    search_data=&{SEARCH_DATA}
    # ارسال درخواست و دریافت پاسخ
    ${response}=    POST On Session    divar    ${ENDPOINT}    headers=&{HEADERS}    json=&{INVALID_BODY}
    Should Be Equal As Integers    ${response.status_code}    400



Send Empty City Id
    [Documentation]    ارسال city_ids خالی
    Create Session    divar    ${BASE_URL}
    &{EMPTY_CITY_BODY}=    Create Dictionary    city_ids=[]    source_view="CATEGORY"    search_data=&{SEARCH_DATA}
    ${response}=    POST On Session    divar    ${ENDPOINT}    headers=&{HEADERS}    json=&{EMPTY_CITY_BODY}
    Should Be Equal As Integers    ${response.status_code}    400

Send Missing Category
    [Documentation]    ارسال درخواستی بدون category در search_data
    Create Session    divar    ${BASE_URL}
    # search_data بدون category:
    &{EMPTY_DATA}=      Create Dictionary    data={}
    &{FORM_DATA_EMPTY}=  Create Dictionary    data={}
    &{SEARCH_DATA_EMPTY}=  Create Dictionary  form_data=&{FORM_DATA_EMPTY}    server_payload=&{SERVER_PAYLOAD}
    &{NO_CATEGORY_BODY}=  Create Dictionary    city_ids=["671"]    source_view="CATEGORY"    search_data=&{SEARCH_DATA_EMPTY}
    ${response}=    POST On Session    divar    ${ENDPOINT}    headers=&{HEADERS}    json=&{NO_CATEGORY_BODY}
    Should Be Equal As Integers    ${response.status_code}    400

Check Response Time For Valid Request
    [Documentation]    ارسال درخواست معتبر و بررسی زمان پاسخگویی
    Create Session    divar    ${BASE_URL}
    ${response}=    POST On Session    divar    ${ENDPOINT}    headers=&{HEADERS}    json=&{VALID_BODY}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be True    ${response.elapsed.total_seconds} < 2    زمان پاسخ نباید بیشتر از 2 ثانیه باشد.

Send Invalid Data Type
    [Documentation]    ارسال پارامتری با نوع داده نامعتبر در city_ids
    Create Session    divar    ${BASE_URL}
    &{INVALID_TYPE_BODY}=    Create Dictionary    city_ids=671    source_view="CATEGORY"    search_data=&{SEARCH_DATA}
    ${response}=    POST On Session    divar    ${ENDPOINT}    headers=&{HEADERS}    json=&{INVALID_TYPE_BODY}
    Should Be Equal As Integers    ${response.status_code}    400


*** Keywords ***
Should Contain Key
    [Arguments]    ${dict}    ${key}
    Dictionary Should Contain Key    ${dict}    ${key}




