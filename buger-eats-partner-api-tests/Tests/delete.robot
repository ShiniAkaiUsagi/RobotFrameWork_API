*** Settings ***
Documentation            DELETE /partners
Suite Setup              Starting API Tests
Resource                 ../Resources/base.robot
Resource                 ../Resources/services.robot


*** Test Cases ***

Should Remove a Partner
    ${partner_id}        POST new partner and return partner ID
    ${response}          DELETE partner by ID    ${partner_id}
    Status Should Be     204

Should Return 404 on Remove a non Partner
    ${partner_id}        POST new partner and return partner ID
    DELETE partner by ID    ${partner_id}
    ${response}          DELETE partner by ID    ${partner_id}
    Status Should Be     404