#uCoach Client

##Goals

##Project Structure
The basic structure of the Ucoach Client is according to the given diagram
![image](http://i.imgur.com/zb82hwq.png)



The project is composed by the current repository and six other repositories. On each repository information about its endpoits, resources and basic functionality are given. 

* [Authentication API][6]
* [Internal Data Service][2]
* [Process Centric Service][4]
* [Business Logic Service][3]
* [Data Service][1]
* [External Data Service][5]



##Use Cases for Final User


As a user: 

* I can register
* I can login
* I can logout
* I can view my personal information
   email, name, birthdate, twitter username
* I can manually track my Health Measures
    weight, calories, steps, blood pressure
* I can connect my Google Fit account 
* I can view the history of my Health Measures
* I can set up personal Goals regarding a Health Measure Type
  * The goals can be frequent (daily frequency) or have a due date
* I can view my Goals
* I receive a motivational message when I register a new Measure that achieve a goal
* I can get a mention on a tweet congratulating me on a Goal achievement


[1]: https://github.com/uCoach/data-service
[2]: https://github.com/uCoach/internal-data-service
[3]: https://github.com/uCoach/business-logic-service
[4]: https://github.com/uCoach/process-centric-service
[5]: https://github.com/uCoach/external-data-service
[6]: https://github.com/uCoach/authentication-api
