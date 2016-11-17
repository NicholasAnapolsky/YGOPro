--Scripted by Eerie Code
--Moonlight Perfume
function c48444114.initial_effect(c)
  --Special Summon
  local e1=Effect.CreateEffect(c)
  e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e1:SetTarget(c48444114.sptg)
  e1:SetOperation(c48444114.spop)
  c:RegisterEffect(e1)
  --Search
  local e2=Effect.CreateEffect(c)
  e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
  e2:SetType(EFFECT_TYPE_IGNITION)
  e2:SetRange(LOCATION_GRAVE)
  e2:SetCost(c48444114.thcost)
  e2:SetTarget(c48444114.thtg)
  e2:SetOperation(c48444114.thop)
  c:RegisterEffect(e2)
end

function c48444114.spfil(c,e,tp)
  return c:IsSetCard(0xdf) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c48444114.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c48444114.spfil(chkc,e,tp) end
  if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c48444114.spfil,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
  local g=Duel.SelectTarget(tp,c48444114.spfil,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
  Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c48444114.spop(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
  end
end

function c48444114.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() and Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
  Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
  Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c48444114.thfil(c)
  return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xdf) and c:IsAbleToHand()
end
function c48444114.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingMatchingCard(c48444114.thfil,tp,LOCATION_DECK,0,1,nil) end
  Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,0)
end
function c48444114.thop(e,tp,eg,ep,ev,re,r,rp)
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
  local g=Duel.SelectMatchingCard(tp,c48444114.thfil,tp,LOCATION_DECK,0,1,1,nil)
  if g:GetCount()>0 then
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
  end
end