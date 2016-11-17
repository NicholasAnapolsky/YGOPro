--Scripted by Eerie Code
--Radiant Divine Bird Vene
function c10441498.initial_effect(c)
	c:EnableReviveLimit()
	--Change Level
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10441498,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c10441498.lvtg)
	e1:SetOperation(c10441498.lvop)
	c:RegisterEffect(e1)
	--Recover monster
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10441498,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_RELEASE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1)
	e2:SetCondition(c10441498.thcon)
	e2:SetTarget(c10441498.thtg)
	e2:SetOperation(c10441498.thop)
	c:RegisterEffect(e2)
end

function c10441498.cfilter(c,tp)
	return c:IsLevelAbove(1) and not c:IsPublic() and Duel.IsExistingTarget(c10441498.lvfil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,c:GetLevel())
end
function c10441498.lvfil(c,lv)
	return c:IsFaceup() and c:IsLevelAbove(1) and c:GetLevel()~=lv
end
function c10441498.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c10441498.lvfil(chkc,e:GetLabel()) end
	if chk==0 then return Duel.IsExistingTarget(c10441498.cfilter,tp,LOCATION_HAND,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local cg=Duel.SelectMatchingCard(tp,c10441498.cfilter,tp,LOCATION_HAND,0,1,1,nil,tp)
	Duel.ConfirmCards(1-tp,cg)
	Duel.ShuffleHand(tp)
	local lv=cg:GetFirst():GetLevel()
	e:SetLabel(lv)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c10441498.lvfil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,lv)
end
function c10441498.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local lv=e:GetLabel()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end

function c10441498.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c10441498.thfilter2,1,e:GetHandler(),tp,r)
end
function c10441498.thfilter2(c,tp,r)
	return c:IsType(TYPE_MONSTER) and c:IsPreviousLocation(LOCATION_ONFIELD+LOCATION_HAND) and c:GetPreviousControler()==tp
end
function c10441498.thfil(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c10441498.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c10441498.thfil(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c10441498.thfil,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c10441498.thfil,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c10441498.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,tp,REASON_EFFECT)
	end
end
