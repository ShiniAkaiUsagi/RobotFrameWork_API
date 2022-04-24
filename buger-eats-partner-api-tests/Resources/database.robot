*** Settings ***
Documentation          Database Helpers Connection
Library                RobotMongoDBLibrary.Delete
Library                RobotMongoDBLibrary.Find


*** Variables ***

&{MONGO_URI}           connection=mongodb+srv://bugereats:7G3nHudYbRm6cvIi@cluster0.rcjhv.mongodb.net/PartnerDB?retryWrites=true&w=majority
...                    database=PartnerDB      collection=partner


*** Keywords ***

Remove Partner By Name
    [Arguments]        ${name}
    ${filter}          Create Dictionary
    ...                name=${name}
    Delete One         ${MONGO_URI}        ${filter}

Remove Partner By ID
    [Arguments]        ${id}
    ${filter}          Create Dictionary
    ...                id=${id}
    Delete One         ${MONGO_URI}        ${filter}

Find Partner By Name
    [Arguments]        ${name}
    ${filter}          Create Dictionary
    ...                name=${name}
    ${results}         Find               ${MONGO_URI}        ${filter}
    [return]           ${results}[0]