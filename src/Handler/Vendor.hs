{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Vendor where

import Import

putVendorR :: VendorId -> Handler Value
putVendorR vid  = do
    vendor <- (requireJsonBody :: Handler Vendor)

    runDB $ replace vid vendor
    sendResponseStatus status200 ("UPDATED" :: Text)

getVendorR :: VendorId -> Handler Value
getVendorR vid = do
    post <- runDB $ get404 vid

    return $ object ["vendor" .= (Entity vid post)]

deleteVendorR :: VendorId -> Handler Value
deleteVendorR vid = do
    runDB $ delete vid

    sendResponseStatus status200 ("DELETED" :: Text)