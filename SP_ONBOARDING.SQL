create or replace procedure sp_onboarding(
                                       p_candidate_name in candidate_onboarding.candidate_name%type,
                                       p_date_of_birth in candidate_onboarding. date_of_birth%type,
                                       p_phone_number in candidate_onboarding.phone_number%type,
                                       p_address in  candidate_onboarding.address%type,
                                       p_permanent_address in candidate_onboarding.permanent_address%type,
                                       p_email_id in  candidate_onboarding.email_id%type,
                                       p_education in  candidate_onboarding.education%type,
                                       p_MARTIAL_STAUS in candidate_onboarding.MARTIAL_STAUS%type,
                                       p_father_name in candidate_onboarding.father_name%type,
                                       p_father_occupation in candidate_onboarding.father_occupation%type,
                                       p_mother_name in candidate_onboarding.mother_name%type,
                                       p_mother_occupation in candidate_onboarding.mother_occupation%type,
                                       p_sibling_name in candidate_onboarding.sibling_name%type,
                                       p_sibling_occupation in candidate_onboarding.SIBLING_OCUPATION%type,
                                       p_sibling_position in candidate_onboarding.sibling_position%type,
                                       p_adhar_number in candidate_onboarding.adhar_number%type,
                                       p_pan_number in candidate_onboarding.pan_number%type)
as

e_invalid_adhar exception;
e_invalid_pan exception;
e_invalid_dob exception;
v_err_msg varchar2(100);

begin
if p_candidate_name is null then
raise_application_error(-20001,'candidate name is required');
end if;

if P_date_of_birth > sysdate or P_date_of_birth is null then
RAISE e_invalid_dob;
end if;



if p_adhar_number is null or length(P_adhar_number)<>12 or not regexp_like (p_adhar_number,'^[0-9]{12}$') then
RAISE e_invalid_adhar;
end if;



if p_pAN_number is null or length(p_pAN_number)<>10 or not regexp_like(p_pAN_numbeR,'^[A-Z]{5}[0-9]{4}[A-Z]{1}$') THEN
RAISE e_invalid_pan;
end if;


INSERT INTO candidate_onboarding(
                                candidate_name,
                                date_of_birth,
                                phone_number,
                                address,
                                permanent_address,
                                email_id,
                                education,
                                MARTIAL_STAUS,
                                father_name,
                                father_occupation,
                                mother_name,
                                mother_occupation,
                                sibling_name,
                                sibling_ocupation,
                                sibling_position,
                                adhar_number,
                                pan_number)                                                       
VALUES                 (p_candidate_name,
                        p_date_of_birth,
                        p_phone_number,
                        p_address,
                        p_permanent_address,
                        p_email_id,
                        p_education,
                        p_MARTIAL_STAUS,
                        p_father_name,
                        p_father_occupation,
                        p_mother_name,
                        p_mother_occupation,
                        p_sibling_name,
                        p_sibling_occupation,
                        p_sibling_position,
                        p_adhar_number,
                        p_pan_number)
                        ;


commit;
dbms_output.put_line('candidate onboarding successsful');



exception
  when e_invalid_adhar then
  v_err_msg:='adhar number is invalid';
  raise_application_error(-20002,v_err_msg);



when e_invalid_dob then
     v_err_msg:='date of birth is not valid';
     raise_application_error(-20002,v_err_msg);


when e_invalid_pan then
    v_err_msg:='pan is invalid ,it is combination of digits and alphabets';
     raise_application_error(-20003,v_err_msg);


when others then
     v_err_msg:=sqlerrm;
     raise_application_error(-20004,v_err_msg);

end;
