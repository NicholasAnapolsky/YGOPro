--wcs2011-08
Debug.SetAIName("高性能电子头脑")
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI)
Debug.SetPlayerInfo(0,100,0,0)
Debug.SetPlayerInfo(1,14000,0,0)
Debug.AddCard(10875327,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(99995595,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(58924378,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(36261276,0,0,LOCATION_SZONE,1,POS_FACEDOWN)
Debug.AddCard(31550470,0,0,LOCATION_SZONE,2,POS_FACEDOWN)
Debug.AddCard(31000575,0,0,LOCATION_SZONE,3,POS_FACEDOWN)
Debug.AddCard(83778600,0,0,LOCATION_SZONE,3,POS_FACEDOWN)
Debug.AddCard(5554990,0,0,LOCATION_MZONE,0,POS_FACEUP_ATTACK)
Debug.AddCard(18407024,0,0,LOCATION_MZONE,1,POS_FACEUP_ATTACK)
Debug.AddCard(81896771,0,0,LOCATION_MZONE,2,POS_FACEUP_ATTACK)
Debug.AddCard(402568,0,0,LOCATION_MZONE,3,POS_FACEUP_ATTACK)
Debug.AddCard(47346845,0,0,LOCATION_MZONE,4,POS_FACEUP_ATTACK)
Debug.AddCard(2772236,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
Debug.AddCard(29765339,0,0,LOCATION_EXTRA,0,POS_FACEDOWN)
Debug.AddCard(75285069,1,1,LOCATION_MZONE,0,POS_FACEUP_ATTACK)
Debug.AddCard(20951752,1,1,LOCATION_MZONE,1,POS_FACEUP_ATTACK)
Debug.AddCard(11260714,1,1,LOCATION_MZONE,2,POS_FACEUP_ATTACK)
Debug.AddCard(5645210,1,1,LOCATION_MZONE,3,POS_FACEUP_ATTACK)
Debug.AddCard(55690251,1,1,LOCATION_MZONE,4,POS_FACEUP_ATTACK)
Debug.AddCard(19252988,1,1,LOCATION_SZONE,2,POS_FACEDOWN)
Debug.AddCard(95701283,1,1,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(47664723,1,1,LOCATION_GRAVE,0,POS_FACEUP)
Debug.ReloadFieldEnd()
Debug.ShowHint("Win in this turn!")
aux.BeginPuzzle()
