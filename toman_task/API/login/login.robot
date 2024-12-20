*** Settings ***
Library    RequestsLibrary
Library    Collections

Test Setup    Create Divar Session   

*** Variables ***
${BASE_URL}        https://api.divar.ir
${ENDPOINT}        /v5/auth/authenticate

&{HEADERS}         accept=application/json, text/plain, */*
...                content-type=application/json
...                origin=https://divar.ir
...                referer=https://divar.ir/
...                x-standard-divar-error=true
...                authority=api.divar.ir
...                accept-language=en-US,en;q=0.9
...                accept-encoding=gzip, deflate, br, zstd
...                content-length=23

${VALID_PHONE}     09121234567
${INVALID_PHONE}   1234
${INVALID_FORMAT}  abcd

*** Keywords ***
Create Divar Session
    Create Session    divar    ${BASE_URL}    


Send Request With Phone
    [Arguments]    ${phone}
    &{body}=    Create Dictionary    phone=${phone}
    ${response}=    POST On Session    divar    ${ENDPOINT}    headers=&{HEADERS}    json=&{body}    
    [Return]    ${response}

Send Request With Phone As Data
    [Arguments]    ${phone}
    &{body}=    Create Dictionary    phone=${phone}        
    ${response}=    POST On Session    divar    ${ENDPOINT}    headers=&{HEADERS}    data=&{body} 
    [Return]    ${response}


*** Test Cases ***
Send Valid Phone Number
    [Documentation]    ارسال یک شماره تلفن معتبر و انتظار دریافت پاسخ موفق
    ${response}=    Send Request With Phone    ${VALID_PHONE}
    Should Be Equal As Integers    ${response.status_code}    200

Send Invalid Phone Number
    [Documentation]    ارسال یک شماره نامعتبر و انتظار دریافت خطا
    ${response}=    Send Request With Phone As Data    ${INVALID_PHONE}
    Should Be Equal As Integers    ${response.status_code}    400

Send Phone With Invalid Format
    [Documentation]    ارسال شماره تلفن با فرمت غیرمجاز
    ${response}=    Send Request With Phone As Data    ${INVALID_FORMAT}
    Should Be Equal As Integers    ${response.status_code}    400

Check Response Time For Valid Phone
    [Documentation]    ارسال شماره معتبر و بررسی زمان پاسخگویی سرویس
    ${response}=    Send Request With Phone            ${VALID_PHONE}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be True    ${response.elapsed.total_seconds()} < 2  msg= زمان پاسخ نباید بیشتر از 2 ثانیه باشد.
