*** Settings ***
Documentation            POST /partners
Suite Setup              Starting API Tests
Resource                 ../Resources/base.robot
Resource                 ../Resources/services.robot


*** Test Cases ***

Should create a new partner
    Creating a new partner

Should return duplicate company email
    [Tags]        bugs
    Creating a duplicate partner

*** Keywords ***


Creating a new partner
    ${partner}         services.New Partner
                       database.Remove Partner By Name      ${partner}[name]
    ${response}    	   services.POST Partner                ${partner}
    Status Should Be   201  # eu estava preferindo a validação direto na keyword :(
    ${result}          database.Find Partner By Name        ${partner}[name]
    Should Be Equal    ${result}[_id]                       ${response.json()}[partner_id]
    
Creating a duplicate partner
    ${partner}         services.New Partner
    database.Remove Partner By Name      ${partner}[name]
    services.POST Partner                ${partner}  #condição para duplicidade de cadastro
    ${response}    	   services.POST Partner                ${partner}
    Status Should Be   409  # eu estava preferindo a validação direto na keyword :(
    Should Be Equal    ${response.json()}[message]          Duplicate company name