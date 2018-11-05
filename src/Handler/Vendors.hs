{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Vendors where

import Import

getVendorsR :: Handler Value
getVendorsR = do
    vendor <- runDB $ selectList [] [] :: Handler [Entity Vendor]

    return $ object ["vendor" .= vendor]

postVendorsR :: Handler ()
postVendorsR = do
    vendor <- requireJsonBody :: Handler Vendor
    _    <- runDB $ insert vendor

    sendResponseStatus status201 ("CREATED" :: Text)
