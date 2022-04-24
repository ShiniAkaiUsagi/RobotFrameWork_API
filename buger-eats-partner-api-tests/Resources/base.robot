*** Settings ***
Documentation            Base
Resource                 ../Resources/services.robot


*** Variables ***

${BASE_URL}         http://localhost:3333/


*** Keywords ***

Starting API Tests
    Create Session          api          ${BASE_URL}