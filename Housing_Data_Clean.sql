delete from MonthlyPerformance
where currentUPB >0

alter table MonthlyPerformance
drop column Report, CurrentUPB, LoanAge, MonthsToMaturity, DefectDate, ModFlag, ZeroBalance, ZeroBalDate, DeferredUPB, 
PaymentDueDate, MIRecoveries, NetSales, NonMIRecoveries, Expenses, LegalCosts, MaintCosts, TaxesInsurance, MiscExpense,
Loss, Modcost, StepMod, DeferredPayPlan, ELTV, ZeroBalRemovalUPB, DelinqAccruedInt, DelinqDisaster, BorrowerAssistance, 
CurrentModCost, IntBearingUPB, IntRate

alter table OriginationData
drop column MSA, Channel, PPM, AmortizationType, PropState, PropType, Postal, Purpose, Seller, Servicer, Conform, 
PreID, Program, HARP, Valuation, InterestOnly, InsuranceCancel

update OriginationData
set FirstTimeHomebuyerFlag = replace(FirstTimeHomebuyerFlag, 'N', 0)

update OriginationData
set FirstTimeHomebuyerFlag = replace(FirstTimeHomebuyerFlag, 'Y', 1)

update MonthlyPerformance
set Delinq = replace(Delinq, 'RA', 30)

alter table MonthlyPerformance
add Def integer

update MonthlyPerformance
set Def = (CASE
					WHEN Delinq < 10
                    THEN 0
					ELSE 1
           END);

ALTER TABLE OriginationData
DROP COLUMN Def

SELECT * 
FROM OriginationData
  inner join MonthlyPerformance
  on OriginationData.ID = MonthlyPerformance.ID
  WHERE FirstPaymentDate<200901 AND DTI<101 AND LTV<101 AND CLTV<101
