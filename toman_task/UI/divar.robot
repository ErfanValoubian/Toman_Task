*** Settings ***
Library    SeleniumLibrary
Test Teardown    Close All Browsers

*** Variables ***
${URL}    https://www.divar.ir
${CITY}   تهران
${REAL_ESTATE}   املاک
${RESIDENTIAL_SALE_TEXT}   فروش مسکونی
${RESIDENTIAL_SALE_LOCATOR}   xpath=//a[text()="${RESIDENTIAL_SALE_TEXT}"]

*** Keywords ***
Open Divar Website
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Page Contains    ${CITY}

Select City
    Click Link    ${CITY}
    Wait Until Page Contains    ${REAL_ESTATE}

Select Real Estate
    Click Link    ${REAL_ESTATE}
    Wait Until Page Contains    ${RESIDENTIAL_SALE_TEXT}

Select Residential Sale
    Click Element    ${RESIDENTIAL_SALE_LOCATOR}


*** Test Cases ***
Navigate And Select Residential Sale
    [Setup]    Open Divar Website
    Select City
    Select Real Estate
    Select Residential Sale
    Sleep    10s

