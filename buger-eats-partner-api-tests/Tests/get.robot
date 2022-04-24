*** Settings ***
Documentation            GET /partners
Suite Setup              Starting API Tests
Resource                 ../Resources/base.robot
Resource                 ../Resources/services.robot


*** Test Cases ***

Should Return a Partner List
    # Pre Condition
    POST random data
    # Test
    ${response}          Get all partners
    Status Should Be     200
    ${size}              Get Length         ${response.json()}
    Should Be True       ${size} > 0        #Teste para validar LISTAS (não contrato)

Should Search Partner By Name
    # Pre Condition
    ${partner}           New Partner
    ${response}          Post Partner                  ${partner}
    #Test
    ${response}          GET partner by name           ${partner}[name]
    Status Should Be     200
    ${size}              Get Length                    ${response.json()}
    Should Be True       ${size} == 1
    Should Be Equal      ${response.json()}[0][name]   ${partner}[name]