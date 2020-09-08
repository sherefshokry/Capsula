//
//  Strings.swift
//  Capsula
//
//  Created by SherifShokry on 12/23/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//

import UIKit
class Strings: Any {
    
    
    static var shared = Strings()
    var hello = "Hello".localize()
    var selectLanguage = "Please select language".localize()
    var availableAt = "Avilable at ".localize()
    var was = "Was".localize()
    var RSD = "RSD".localize()
    var VAT = "VAT".localize()
    var freeDelivery = "Free Dlivery".localize()
    var offer = "Offer".localize()
    var discount = "Discount".localize()
    var trackOrder = "Track Order".localize()
    var clearAll = "Clear All".localize()
    var items = "Items".localize()
    var itemAdded = "Item added to cart successfully".localize()
    var chooseOption = "Choose Option".localize()
    var addAddress = "Add New Address".localize()
    var cartMsg = "Add Products to cart & Redirect to Checkout".localize()
    var moreDetails = "More Details".localize()
    var pending = "Pending".localize()
    var cancelled = "Cancelled".localize()
    var rejected = "Rejected".localize()
    var approved = "Approved".localize()
    var shipped = "Shipped".localize()
    var delivered = "Delivered".localize()
    var skipped = "Skipped".localize()
    var inProgress = "In Progress".localize()
    var orderIs = "Order is".localize()
    var cash = "Cash on Delivery".localize()
    var creditCard = "Credit Card".localize()
    var applePay = "Apple Pay".localize()
    var stcPay = "STC Pay".localize()
    var madaPay = "Mada".localize()
    var googlePay = "Google Pay".localize()
    var pleaseLogin = "Please login first".localize()
    var citizenship = "Citizenship".localize()
    var nationalID = "National ID".localize()
    var bankAccount = "Bank Account (optional)".localize()
    var fullAddress = "Full Address".localize()
    var requiredField = "required field".localize()
    var termsAndConditons = "Terms & conditions".localize()
    var selectNationality = "Select your nationality".localize()
    var nationalIDValidation = "please enter a valid national id".localize()
    var carBrand = "Car Brand".localize()
    var carModel = "Car Model".localize()
    var modelYear = "Model Year".localize()
    var model = "Model".localize()
    var vechileDetails = "Vehicle Plate Details".localize()
    var plateNumber = "Plate Number".localize()
    var plateLetters = "Plate Letters".localize()
    var licenceType = "Licence Type".localize()
    var pickBrandFirst = "please, pick car brand first".localize()
    var selectModel = "Select car model".localize()
    var selectYear = "Select car model year".localize()
    var selectLicence = "Select car licence type".localize()
    var selectBrand = "Select car brand".localize()
    var deliveryRegistrationSuccess = "your request has been sent successfully".localize()
    var orderID  = "Order ID : ".localize()
    var clearCartMsg1  = "Your cart contains items from ".localize()
    var clearCartMsg2  = " Do you wish to clear your cart and start a new order here ?".localize()
    var privacyPolicyErrorMsg = "Please agree on terms and conditions) (please Pick this photo".localize()
    var navigate =  "Navigate".localize()
    var cashPayment = "Total cost is greater than 500 RSD, so you have to proceed with online payment".localize()
    var paymentMethodSelection = "Please,select your prefered payment method".localize()
    var km = " KM".localize()
    var distance = "Distance : ".localize()
    var userProfileUpdatedMsg =  "User profile updated successfully".localize()
    var resetPasswordSuccessMsg = "Your password is updated successfully".localize()
    var password = "Password *".localize()
    var confirmationPassword = "Confirm Password *".localize()
    var newPassword  = "New Password *".localize()
    var phoneMatched = "password and confirm password are not matched".localize()
    var cardAddedSuccessfully = "Your card is added successfully".localize()
    var arabic = "العربيه"
    var english = "English"
    var clear = "Clear".localize()
    var rsd = " RSD".localize()
    var categories = "Categories".localize()
    var stores = "Stores".localize()
    var seeAll = "See All".localize()
    var skip = "Skip".localize()
    var forgetPassword = "Forget Password".localize()
    var OK = "OK".localize()
    var currentLocation = "Current Location".localize()
    var gallery = "Photo Library".localize()
    var camera = "Take Photo".localize()
    var sendAgain = "Send Again".localize()
    var resendMessage_1 =   "You can resend code after ".localize()
    var resendMessage_2 =   " second".localize()
    var alreadyExist = "User already exist".localize()
    var notExist = "User not registered yet".localize()
    var yes = "Yes".localize()
    var no = "No".localize()
    
    
    struct Fields {
        static var shared = Fields()
        var phoneOrEmail = "Phone or Email".localize()
        var location = "Location".localize()
        var name = "Name *".localize()
        var email = "Email *".localize()
        var phone = "Mobile Number *".localize()
        var modelYear = "Model Year *".localize()
    }
    
    
    struct Validation {
        static var shared = Validation()
        var codeNullMsg = "Please enter code".localize()
        var dropDownValidation = "Please select your ".localize()
        var fieldValidation = "Please enter a valid ".localize()
        var nameValidation = "Please enter a valid name (3+ characters)".localize()
        var mailValidation = "Please enter a valid email".localize()
        var phoneValidation = "Please enter a valid phone number".localize()
        var messageValidation = "Please enter your message".localize()
        var codeValidation = "code not valid".localize()
        
        var verificationCodeNotValid = "Verification code is not valid".localize()
        var passwordPolicyValidation = "Password must be minimum 6 characters".localize()
        //and contain at least 1 Alphabet and 1 Number
        var passwordEmpty = "Please enter a password".localize()
        var userNotRegistered = "This phone number is not registered yet".localize()
        var loginValidation = "mobile number or password is invalid".localize()
        var cancelError = "Please enter a cancellation reason".localize()
        var generalFieldValidation = "Field can't be empty".localize()
    }
    
    static func refreshAll(){
        Strings.Fields.shared = Strings.Fields()
        Strings.Validation.shared = Strings.Validation()
        Strings.SideMenu.shared = Strings.SideMenu()
        
    }
    
    
    struct Pagination {
        static var perPage = 10
    }
    
    
    struct SideMenu {
        static var shared = SideMenu()
        var Profile = "Personal Details".localize()
        var MyOrders = "My Orders".localize()
        var Payment = "Manage Payment Methods".localize()
        var Help = "Help".localize()
        var PromoCode  = "Promo codes".localize()
        var Share = "Share and Earn".localize()
        var Notifications = "Enable Notifications".localize()
        var FAQ = "FAQs".localize()
        var Logout = "Logout".localize()
        var LogIn = "LogIn".localize()
        var History = "History".localize()
        var MyWallet = "My Wallet".localize()
        var Language = "Language".localize()
        var About = "About us".localize()
        var Terms = "Terms & Conditions".localize()
    }
    
    
    
}
