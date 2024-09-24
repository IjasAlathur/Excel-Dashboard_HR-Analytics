create database excelr_project_2;
use excelr_project_2;

select * from employee_data;

/* 1st KPI
Average Attrition Rate for All Department */ 

select department,  AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Avg_Attrition_Rate from employee_data group by department;

select a.department, concat(format(avg(attrition_yes)*100,2),"%") as Attrition_Rate
from
(select department,attrition,
case
when attrition = "YES" 
then 1
else 0 
end as attrition_yes from hr_1) as a
group by a.department
order by a.department;

/* 2nd KPI
Average Hourly Rate for Male Research Scientist */

SELECT jobrole, AVG(HourlyRate) AS Avg_Hourly_Rate FROM employee_data WHERE Gender = 'Male' AND JobRole = 'Research Scientist';

/* 3rd KPI
AttritionRate VS MonthlyIncomeStats against department */

SELECT Attrition, AVG(MonthlyIncome) AS Avg_Monthly_Income FROM employee_data GROUP BY Attrition;

/* 4th KPI
*/

SELECT Department, AVG(YearsAtCompany) AS Avg_Working_Years FROM employee_data GROUP BY Department;

/* 5th KPI
Job Role VS Work Life Balance */

alter table hr_2 rename column `Employee ID` to EmployeeID;

SELECT JobRole, avg(WorkLifeBal) AS Avg_Work_Life_Balance FROM employee_data GROUP BY JobRole;

select JobRole, count(performancerating) as Total_Employee, format(avg(WorkLifeBal),2) as Avg_WorkLifeBalance
from hr_1
inner join hr_2 on EmployeeID = Employeenumber
group by jobrole;

/* 6th KPI
Attrition Rate Vs Year Since Last Promotion Relation Against Job Role */

SELECT YearsSinceLastPromotion, AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Rate FROM employee_data GROUP BY YearsSinceLastPromotion;

select JobRole,concat(format(avg(attrition_rate)*100,2),'%') as Avg_Attrition_Rate,
format(avg(YearsSinceLastPromotion),2) as Avg_YearsSinceLastPromotion
from ( select JobRole,attrition,employeenumber,
case 
when attrition = 'yes' 
then 1
else 0
end as attrition_rate from hr_1) as a
inner join hr_2 on employeeid = employeenumber
group by JobRole;