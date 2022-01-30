%function [ NPV, ROI ] = cashflow( power,costperwatt,DR, ER,SREC,ProducedElectricity,LifeTime)
power = 6; %kw
costperwatt = 5.94;
ElectricityPrice = .1657;  %%% $/kWh
ER =0.001778;
DR=.03;
ProducedElectricity = 9219.9; %monthly need*12 kwh
loss = .005 ;
SREC=279.5;
LifeTime = 25;

TaxRate = .07;
InsuranceRate = 0.005;
MaintananceRate = .005; 
InitialCost = power * 1000 * costperwatt;
InitialInvestment = InitialCost * (1+ TaxRate);

%AnnCons = 12 * Load;

%if (AnnCons > ProducedElectricity)
%end

NPV = ones(25,1);
elecricity = ones(25,1);
srec = ones(25,1);
TaxCredit = .3 * InitialCost;
max_tax_credit = power *1000 * 1;
if TaxCredit > max_tax_credit;
    TaxCredit = max_tax_credit;
end
NPV(1,1) = TaxCredit/(1 + DR) - InitialInvestment + SREC * ProducedElectricity/1000 + ElectricityPrice  * ProducedElectricity;
indicator = 0;
for year = 2:LifeTime
    CashFlow = SREC * ProducedElectricity*(1-loss)^(year-1)/1000 + ElectricityPrice * (1 + ER)^(year - 1) * ProducedElectricity *(1-loss)^(year-1)-  (InsuranceRate + MaintananceRate) * InitialCost;
    NPV(year) = NPV(year-1) + CashFlow/( 1 + DR )^( year - 1);
    if (NPV(year) >= 0 && indicator == 0)
        indicator = 1;
        ROI = year;
    end 
    if indicator == 0
        ROI = 0;
    end

end


NPV
ROI
InitialInvestment
%electricity





%end