--Scripted by Eerie Code
--Amorphous Persona
function c23160024.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Increase ATK/DEF
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetValue(300)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xe0))
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENCE)
	c:RegisterEffect(e3)
	--Draw
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(23160024,0))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_RELEASE)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(2)
	e4:SetCondition(c23160024.drcon)
	e4:SetOperation(c23160024.drop)
	c:RegisterEffect(e4)
	--Ritual Summon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(23160024,1))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_GRAVE)
	e5:SetCost(c23160024.spcost)
	e5:SetTarget(c23160024.sptg)
	e5:SetOperation(c23160024.spop)
	c:RegisterEffect(e5)
end

function c23160024.drfil(c,tp,r)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xe0) and c:IsPreviousLocation(LOCATION_ONFIELD) and c:GetPreviousControler()==tp
end
function c23160024.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c23160024.drfil,1,nil,tp,r)
end
function c23160024.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,23160024)
	Duel.Draw(tp,1,REASON_EFFECT)
end

function c23160024.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c23160024.filter(c,e,tp,m)
	if not c:IsCode(98287529) or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) then return false end
	local mg=m:Filter(Card.IsCanBeRitualMaterial,c,c)
	if c.mat_filter then
		mg=mg:Filter(c.mat_filter,nil)
	end
	return mg:CheckWithSumEqual(Card.GetRitualLevel,8,1,99,c)
end
function c23160024.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg=Duel.GetRitualMaterial(tp):Filter(Card.IsType,nil,TYPE_PENDULUM)
		return Duel.IsExistingMatchingCard(c23160024.filter,tp,LOCATION_HAND,0,1,nil,e,tp,mg)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c23160024.spop(e,tp,eg,ep,ev,re,r,rp)
	local mg=Duel.GetRitualMaterial(tp):Filter(Card.IsType,nil,TYPE_PENDULUM)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c23160024.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp,mg)
	local tc=tg:GetFirst()
	if tc then
		mg=mg:Filter(Card.IsCanBeRitualMaterial,tc,tc)
		if tc.mat_filter then
			mg=mg:Filter(tc.mat_filter,nil)
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local mat=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,8,1,99,tc)
		tc:SetMaterial(mat)
		Duel.ReleaseRitualMaterial(mat)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
