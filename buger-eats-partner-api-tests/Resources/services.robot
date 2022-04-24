*** Settings ***
Documentation        Camada de Serviços
Library              RequestsLibrary
Library              FakerLibrary    locale=pt_BR
Library    DatabaseLibrary
Resource             ../Resources/database.robot
Resource             ../Resources/services.robot


*** Variables ***

&{HEADERS}          content-Type=application/json    auth_user=qa    auth_password=ninja
${emailCount}       ${0}
@{NEGOCIO}          Restaurante    Supermercado    Conveniência

*** Keywords ***

Creating Fake Data
    # Algumas preparações
    ${emailCount}   FakerLibrary.Pyint    00000000    99999999    1
    ${ddd}          FakerLibrary.Pyint    11          99          1
    ${phone}        FakerLibrary.Pyint    00000000    99999999    1

    # Fake Data :)
    ${name}         FakerLibrary.Name
    ${email}        Catenate    pedro.dias+${emailCount}@toroinvestimentos.com.br
    ${whatsapp}     Catenate    ${ddd}9${phone}
    ${business}     Evaluate    random.choice(${NEGOCIO})
    # Set Test Variable
    Set Suite Variable          ${name}
    Set Suite Variable          ${email}
    Set Suite Variable          ${whatsapp}
    Set Suite Variable          ${business}

New Partner
    Creating Fake Data
    ${payload}         Create Dictionary
    ...                name=${name}
    ...                email=${email}
    ...                whatsapp=${whatsapp}
    ...                business=${business}
    [Return]           ${payload}

POST Partner
    [Arguments]        ${payload}
    ${response}        POST On Session     alias=api     url=partners
    ...                json=${payload}
    ...                headers=${HEADERS}
    ...                expected_status=any
    [return]           ${response}

GET all partners
    ${response}        GET On Session       alias=api     url=partners
    ...                headers=${HEADERS}
    ...                expected_status=any
    [return]           ${response}

GET partner by name
    [Arguments]    ${name}
    ${Query}           Create Dictionary    name=${name}
    ${response}        GET On Session       alias=api     url=partners
    ...                params=${query}
    ...                headers=${HEADERS}
    ...                expected_status=any
    [return]           ${response}

POST random data
    FOR     ${counter}    IN RANGE    0    3
        ${partner}     New Partner
                       database.Remove Partner By Name      ${name}
        ${response}    services.POST Partner                ${partner}
    END

PUT Enable Partner
    [Arguments]        ${partner_id}
    ${response}        PUT On Session     alias=api     url=partners/${partner_id}/enable
    ...                headers=${HEADERS}
    ...                expected_status=any
    [return]           ${response}

PUT Disable Partner
    [Arguments]        ${partner_id}
    ${response}        PUT On Session     alias=api     url=partners/${partner_id}/disable
    ...                headers=${HEADERS}
    ...                expected_status=any
    [return]           ${response}

POST new partner and return partner ID
    ${partner}        New Partner
                      Remove Partner By Name    ${partner}[name]
    ${response}       POST Partner          ${partner}
    [Return]          ${response.json()}[partner_id]

DELETE partner by ID
    [Arguments]        ${partner_id}
    ${response}        DELETE On Session     alias=api     url=partners/${partner_id}
    ...                headers=${HEADERS}
    ...                expected_status=any
    [return]           ${response}