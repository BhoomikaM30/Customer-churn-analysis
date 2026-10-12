create database kaggle_churn;
use kaggle_churn;
select * from churn_clean;

-- churn rate 
select round((select count(churn) from churn_clean where churn="Yes")/(select count(churn) from churn_clean),2)*100 as churn_rate;
-- amount of revenue losing because of churn 
select churn , round(sum(monthlycharges),2) as monthly_lost from churn_clean where churn = "yes";

-- churn_rate by contract  type 
select contract , count(*) as customers , sum(case when churn = "Yes" then 1 else 0 end) as churned , round(sum(case when churn = "Yes" then 1 else 0 end) / count(*),2)* 100
as churn_rate_pct from churn_clean group by contract order by churn_rate_pct;

select phoneService , count(*) as customers , round(sum(case when churn="yes" then 1 else 0 end)/ count(*),2)*100 as churn_pct from churn_clean 
where contract = "month-to-month" group by phoneService order by churn_pct;

select InternetService , count(*) as customers , round(sum(case when churn="yes" then 1 else 0 end)/ count(*),2)*100 as churn_pct from churn_clean 
where contract = "month-to-month" group by InternetService order by churn_pct;

-- tech support
select techsupport, count(*) as customers,
  round(100.0 * sum(case when churn = 'Yes' then 1 else 0 end) / count(*), 2) as churn_pct
from churn_clean
where contract = 'Month-to-month'
group by techsupport
order by churn_pct desc;

-- online security
select onlinesecurity, count(*) as customers,
  round(100.0 * sum(case when churn = 'Yes' then 1 else 0 end) / count(*), 2) as churn_pct
from churn_clean
where contract = 'Month-to-month'
group by onlinesecurity
order by churn_pct desc;

-- online backup
select onlinebackup, count(*) as customers,
  round(100.0 * sum(case when churn = 'Yes' then 1 else 0 end) / count(*), 2) as churn_pct
from churn_clean
where contract = 'Month-to-month'
group by onlinebackup
order by churn_pct desc;

-- device protection
select deviceprotection, count(*) as customers,
  round(100.0 * sum(case when churn = 'Yes' then 1 else 0 end) / count(*), 2) as churn_pct
from churn_clean
where contract = 'Month-to-month'
group by deviceprotection
order by churn_pct desc;

-- streaming tv
select streamingtv, count(*) as customers,
  round(100.0 * sum(case when churn = 'Yes' then 1 else 0 end) / count(*), 2) as churn_pct
from churn_clean
where contract = 'Month-to-month'
group by streamingtv
order by churn_pct desc;

-- streaming movies
select streamingmovies, count(*) as customers,
  round(100.0 * sum(case when churn = 'Yes' then 1 else 0 end) / count(*), 2) as churn_pct
from churn_clean
where contract = 'Month-to-month'
group by streamingmovies
order by churn_pct desc;

-- multiple lines
select multiplelines, count(*) as customers,
  round(100.0 * sum(case when churn = 'Yes' then 1 else 0 end) / count(*), 2) as churn_pct
from churn_clean
where contract = 'Month-to-month'
group by multiplelines
order by churn_pct desc;
-- by tenure 
select case when tenure <= 12 then '0-12 months'
            when tenure <= 24 then '13-24 months'
            when tenure <= 48 then '25-48 months'
            else '49+ months' end as tenure_group,
       count(*) as customers,
       round(100.0 * sum(case when churn = 'Yes' then 1 else 0 end) / count(*), 2) as churn_pct
from churn_clean
group by tenure_group
order by min(tenure);

select paymentmethod, count(*) as customers,
round(100.0 * sum(case when churn = 'Yes' then 1 else 0 end) / count(*), 2) as churn_pct
from churn_clean
group by paymentmethod
order by churn_pct desc;

select contract, round(sum(monthlycharges), 2) as monthly_revenue_lost
from churn_clean
where churn = 'Yes'
group by contract
order by monthly_revenue_lost desc;
