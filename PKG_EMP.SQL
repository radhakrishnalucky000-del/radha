create or replace package pkg_emp as
v_name employees.first_name%type;
v_age employees.salary%type;
v_salary employees.salary%type;
procedure sp_emp(p_emp in number);
procedure sp_emp(p_emp in number,p_salary in number);
function fn_emp(p_emp in number)return varchar2;
end pkg_emp;