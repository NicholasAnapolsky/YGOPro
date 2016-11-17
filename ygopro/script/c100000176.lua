--怪猫変化
function c100000176.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c100000176.cona)
	e1:SetTarget(c100000176.tga)
	e1:SetOperation(c100000176.opa)
	c:RegisterEffect(e1)
end
function c100000176.spfilter(c,tp)
	return c:GetControler()==tp and c:GetCode()==100000170
end
function c100000176.cona(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c100000176.spfilter,1,nil,tp)
end
function c100000176.filter(c,e,tp)
	return c:GetCode()==100000177 and c:IsCanBeSpecialSummoned(e,0,tp,true,true) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c100000176.tga(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c100000176.filter,tp,0x13,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c100000176.opa(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000176.filter,tp,0x13,0,1,1,nil,e,tp)
	Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
end
