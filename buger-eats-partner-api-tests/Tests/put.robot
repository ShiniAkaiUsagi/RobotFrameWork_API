*** Settings ***
Documentation            PUT /partners
Suite Setup              Starting API Tests
Resource                 ../Resources/base.robot
Resource                 ../Resources/services.robot


*** Test Cases ***

Should Enable a Partner
    ${partner_id}     POST new partner and return partner ID
    ${response}       PUT Enable Partner    ${partner_id}
    Status Should Be    200

Should return 404 on enable a non partner
    ${partner_id}     POST new partner and return partner ID
    Remove Partner By ID    ${partner_id}
    ${response}       PUT Enable Partner    ${partner_id}
    Status Should Be    404

Should Disable a Partner
    # Pre condition
    ${partner_id}     POST new partner and return partner ID
    ${response}       PUT Enable Partner    ${partner_id}
    # Test
    ${response}       PUT Disable Partner    ${partner_id}
    Status Should Be    200

Should return 404 on disable a non partner
    ${partner_id}     POST new partner and return partner ID
    Remove Partner By ID    ${partner_id}
    ${response}       PUT Disable Partner    ${partner_id}
    Status Should Be    404