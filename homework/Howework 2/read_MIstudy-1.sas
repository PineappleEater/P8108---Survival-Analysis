options ls=78 nodate;

data MIstudy;
  infile 'MIstudy.dat';
  input @1 id @5 age @10 gender @15 hr f3. @22 sysbp f3. @27 diasbp f3.
      @33 bmi f7.4 @44 cvd f3. @49 afib f3. @54 shock f3. @58 chf f3. 
      @62 av3 f3. @67 miord f3. @72 mitype f3. @77 year f3. 
      @82 los f3. @87 dstat f3. @92 dthtime f8.4 @105 dthstat f3.
      @110 obese f3. @115 overweight f3. @120 obese_ovwt f3.;
  label id='ID #'
        age='Patient age (yrs)'
        gender='Sex (0=male, 1=female)'
        hr='Heart rate'
        sysbp='Systolic BP'
        diasbp='Diastolic BP'
        bmi='BMI (kg/m^2)'
        cvd='History of cardiovascular disease'
        afib='Atrial fibrillation'
        shock='Cardiogenic shock'
        chf='Congestive heart failure'
        av3='Complete heart block'
        miord='MI order (0=first,1=recurrent)'
        mitype='MI Type (0=non Q-wave, Q-wave)'
        year='Year of cohort (1=1997, 2=1999, 3=2001)'
        los='Length of hospital stay (days)'
        dstat='Hospital discharge status (0=alive,1=dead)'
        dthtime='Time to death or follow-up (months)'
        dthstat='Vital status (0=alive, 1=dead)'
        obese='Obese (BMI>=30)'
        overweight='Overweight (BMI 25-29.9)'
        obese_ovwt='Obese/Overweight (BMI>=25)';
run;

proc contents data=MIstudy;
  title 'Contents of Worcester Heart Attack Study dataset';

proc means data=Mistudy;
  var  age hr sysbp diasbp bmi chf obese overweight obese_ovwt;
  title 'means of a few study variables';
run;
