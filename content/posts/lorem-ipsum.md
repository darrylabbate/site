+++
title  = 'Epaphus sunt'
author = 'Darryl Abbate'
date   = '2018/12/26'
url    = '/lorem-ipsum/'
+++

## Domos nymphae saepius

Lorem **markdownum**, novabis, Aeaciden vitiatur **tactis**, inde funera.  **Disce tum**, tu mox `crescendo` et elige unam erit volucresque. Caecaque insula et mihi et Paris angustum vidi!

> This is a block of quoted text

Regem fraxinus Iason tentoria io inducto certe, est parvae pectine, quoque.  Operiri tellus legi vultus crimine. Tamen quoque: ictus de mori erat posuisset laesasque usque, quis parvus huic quemquam, venit. Quae nova. Dum nova sed silvas corpore adspiceres puerilibus tangi, [massa innectens sonabat](http://tefulvaque.io/nam.aspx)!

- Cum quid posset
- Superabat patrem sceleri demisere uritur
- Paludes ambo obstipuit quatenus nunc bella relevare

## Crimen crevit certe

Repetitaque regia capillis! Ut nunc carbasa, in tulit viribus, inrequieta [me vivaque nam](http://www.velquid.net/redeunt.aspx) loquar edentem, esse vale.  Aures pater Leuconoe; mihi cuspide crescit quos dira, neu et fixit incepto. Mea inque, fiet trado, ridet quid deficiunt, dies adunci pectore Cereris.

```haskell
{-# LANGUAGE OverloadedStrings #-}

module LunarPhase where

import           Data.Fixed
import           Data.Text
import           Data.Time
import           Data.Time.Calendar.Julian

data Phase = New
           | WaxingCrescent
           | FirstQuarter
           | WaxingGibbous
           | Full
           | WaningGibbous
           | ThirdQuarter
           | WaningCrescent
           deriving (Eq, Show)

moonRevolution = 29.530588853

calcPhase :: Integer -> Int -> Int -> Phase
calcPhase y m d = phase . flip mod' moonRevolution . fromIntegral $
                  diffDays (fromJulian y m d) (fromJulian 2000 1 6) where
                  phase x | x < 0.94566  = New
                          | x < 7.53699  = WaxingCrescent
                          | x < 9.22831  = FirstQuarter
                          | x < 13.91963 = WaxingGibbous
                          | x < 15.61096 = Full
                          | x < 21.80228 = WaningGibbous
                          | x < 22.59361 = ThirdQuarter
                          | x < 28.68493 = WaningCrescent
                          | otherwise    = New
```

Est nec densumque *quam* dictis Pallas, mihi verba nam et dabat. Aesculeae gemitus defuit membra sceleris, illic; mediam habes, maledictaque. Ales pomaria se lumbis quam sequiturque neve invidiosa voces horrendaque caecus capit ait excussam solos. Est ipse metu *terris* et terra fratres, et sanguine dixit anumque studiosus tu nivea, corpore notat deos, Palladaque.

Egeriae alebat. Nate habuit; ille ferebat [Proserpina](http://ad.io/), illa vacuas, Parosque? Vallis melius [carminibus](http://doceri.io/) blandis aves ex stagnata lingua totaque; **quid cuius** quo ulterius! Residens [quam](http://sine-committit.net/) cum, fugiant quoniam; Iove litore latus?
