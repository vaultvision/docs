NoCode Deployment Options
==============

HTML Dynamic Auth Elements and Class Name
==============

##Specific Auth Element
auth-button [auth-button-settings, auth-button-login, auth-button-logout, auth-button-signup]
auth-href-issuer-settings Will change the href attribute of to the location of the User Settings page provided by the issuer

#Generic Auth Clases
.authed - a CSS class that will trigger the element to be visible when there is an authenticated user (have its d-none class removed.  NOTE: element must initially have a d-none class)
.unauthed - a CSS class that will trigger the element to be visible when there is NO authenticated user (have its d-none class removed.  NOTE: element must initially have a d-none class)

#Generic Auth Field
These elements will prefill certain attributes based on the field passed in the data-auth-user-field attribute, if the data is falsey, those attributes will be defaulted to what is passed in the data-auth-default attribute
auth-src [auth-src-user, auth-src-table ]
auth-label [auth-label-user, auth-label-table ]
auth-list [auth-list-table]


#Data attributes
data-auth-href
data-auth-user-field - this is the field on the user object that will be used to populate the HTML element. (ex. name, email)
data-auth-default - this is the value to populate the HTML element when the field is falsey
data-auth-table - this is the name of the table that will be the source of data for this element
data-auth-baseid - this is the id for the AirTable base that contains the table
data-auth-table-field - this is the field/column from the table that will be used to populate the HTML element
data-auth-table-cache - this can either be: "page" or "none"; "page" will mean that the data call is only made once per page load, "none" means the data call will be made for each element rather than caching.  By using "page" the data is cached once per page load so it can be re-used by multiple elements without making multiple calls. 
data-auth-table-ul-class - this is the class list that will be applied to the UL element, can be multiple as a space separated string
data-auth-table-li-class - this is the class list that will be applied to the LI element, can be multiple as a space separated string
data-auth-table-templatestring - this is a JS template literal string that will do a field replacement based on using ${field} (ex. data-auth-table-templatestring="Hello ${field}, how is your day)"; ${field} must be exactly ${field} and not the name of the field set in data-auth-table-field 
