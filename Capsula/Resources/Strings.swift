//
//  Strings.swift
//  Capsula
//
//  Created by SherifShokry on 12/23/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//


import UIKit
class Strings: Any {
    
    
    static var availableAt = "Avilable at ".localize()
    static var wasRSD = "Was RSD".localize()
    static var RSD = "RSD".localize()
    static var VAT = "VAT".localize()
    static var freeDelivery = "Free Dlivery".localize()
    static var offer = "Offer".localize()
    static var discount = "Discount".localize()
    static var trackOrder = "Track Order".localize()
    static var clearAll = "Clear All".localize()
    static var items = "Items".localize()
    static var itemAdded = "Item added to cart successfully".localize()
    static var chooseOption = "Choose Option".localize()
    static var addAddress = "Add New Address".localize()
    static var cartMsg = "Add Products to cart & Redirect to Checkout".localize()
    static var moreDetails = "More Details".localize()
    static var pending = "Pending".localize()
    static var cancelled = "Cancelled".localize()
    static var rejected = "Rejected".localize()
    static var approved = "Approved".localize()
    static var shipped = "Shipped".localize()
    static var delivered = "Delivered".localize()
    static var skipped = "Skipped".localize()
    static var inProgress = "In Progress".localize()
    static var orderIs = "Order is".localize()
    static var cash = "Cash on Delivery".localize()
    static var creditCard = "Credit Card".localize()
    static var applePay = "Apple Pay".localize()
    static var stcPay = "STC Pay".localize()
    static var madaPay = "Mada".localize()
    static var googlePay = "Google Pay".localize()
    static var pleaseLogin = "Please login first".localize()
    static var citizenship = "Citizenship".localize()
    static var nationalID = "National ID".localize()
    static var bankAccount = "Bank Account (optional)".localize()
    static var fullAddress = "Full Address".localize()
    static var requiredField = "required field".localize()
    static var termsAndConditons = "Terms & conditions".localize()
    static var selectNationality = "Select your nationality".localize()
    static var nationalIDValidation = "please enter a valid national id".localize()
    static var carBrand = "Car Brand".localize()
    static var carModel = "Car Model".localize()
    static var modelYear = "Model Year".localize()
    static var model = "Model".localize()
    static var vechileDetails = "Vechile Plate Details".localize()
    static var plateNumber = "Plate Number".localize()
    static var plateLetters = "Plate Letters".localize()
    static var licenceType = "Licence Type".localize()
    static var pickBrandFirst = "please, pick car brand first".localize()
    static var selectModel = "Select car model".localize()
    static var selectYear = "Select car model year".localize()
    static var selectLicence = "Select car licence type".localize()
    static var selectBrand = "Select car brand".localize()
    static var deliveryRegistrationSuccess = "your request has been sent successfully".localize()
    static var orderID  = "Order ID : ".localize()
    static var clearCartMsg1  = "Your cart contains items from ".localize()
    static var clearCartMsg2  = " Do you wish to clear your cart and start a new order here ?".localize()
    static var privacyPolicyErrorMsg = "Please agree on terms and conditions) (please Pick this photo".localize()
    static var navigate =  "Navigate".localize()
    static var cashPayment = "Total cost is greater than 500 RSD, so you have to proceed with online payment".localize()
    static var paymentMethodSelection = "Please,select your prefered payment method".localize()
    static var km = " KM".localize()
    static var distance = "Distance : ".localize()
    static var userProfileUpdatedMsg =  "User profile updated successfully".localize()
    static var resetPasswordSuccessMsg = "Your password is updated successfully".localize()
    static var password = "Password *".localize()
    static var confirmationPassword = "Confirm Password *".localize()
    static var newPassword  = "New Password *".localize()
    static var phoneMatched = "password and confirm password are not matched".localize()
    static var cardAddedSuccessfully = "Your card is added successfully".localize()

    
    
    
    
    static var clear = "Clear".localize()
    static var rsd = " RSD".localize()
    static var categories = "Categories".localize()
    static var stores = "Stores".localize()
    static var seeAll = "See All".localize()
    static var skip = "Skip".localize()
    static var forgetPassword = "Forget Password".localize()
    static var currentLocation = "Current Location".localize()
    static var alreadyExist = "User already exist".localize()
    static var notExist = "User not registered yet".localize()
     static var gallery = "Photo Library".localize()
    static var camera = "Take Photo".localize()
    static var showRoom = "Showroom".localize()
    static var serviceCenter = "Service Center".localize()
    static var spareParts = "Spare Parts".localize()
    static var AllBrands = "All Brands".localize()
    static var getDirection = "Get Direction".localize()
    static var register = "Register".localize()
    static var login = "Login".localize()
    static var vin = "How to get my car number?".localize()
    static var sendAgain = "Send Again".localize()
    static var resendMessage_1 =   "You can resend code after ".localize()
    static var resendMessage_2 =   " second".localize()
   static var updateProfileSuccessMsg = "Your profile is updated successfully".localize()

    static var change = "Change".localize()
    static var saveMsg = "No changes to save".localize()
    static var cancel = "Cancel".localize()
    static var welcome = "Welcome ".localize()
    static var done = "Done".localize()
    static var createAccount = "Create account".localize()
    static var price = "Price : ".localize()
    static var available = "Available in Store".localize()
    static var notAvailable = "Out of stock".localize()
    static var year = " year".localize()
    static var years = " years".localize()
    static var yes = "Yes".localize()
    static var no = "No".localize()
    static var egp = " EGP".localize()
    static var delete = "Delete".localize()
    static var OK = "OK".localize()
    static var viewMore = "View More".localize()
    static var or = " or ".localize()
    static var arabic = "العربيه"
    static var english = "English"
    
    struct Fields {
        static var phoneOrEmail = "Phone or Email".localize()
        
        static var location = "Location".localize()
        static var date = "Date".localize()
        static var time = "Time".localize()
        static var name = "Name *".localize()
        static var email = "Email *".localize()
        static var phone = "Mobile Number *".localize()
        static var brandRequired = "Brand *".localize()
        static var categoryRequired = "Category *".localize()
        static var modelRequired = "Model *".localize()
        static var category = "Category".localize()
        static var kmFieldHint = "Please enter kilometer".localize()
        static var kmFieldPlaceHolder = "Kilometer *".localize()
        static var modelYear = "Model Year *".localize()
        static var message = "Message *".localize()
        static var someThing = "Write Something...".localize()
      
      
    }
    struct Validation {
        static var kilometerValidation = "kilometer must be between 100 to 100,000 km".localize()
        static var dropDownValidation = "Please select your ".localize()
        static var fieldValidation = "Please enter a valid ".localize()
        static var nameValidation = "Please enter a valid name (3+ characters)".localize()
        static var mailValidation = "Please enter a valid email".localize()
        static var phoneValidation = "Please enter a valid phone number".localize()
        static var messageValidation = "Please enter your message".localize()
        static var codeValidation = "code not valid".localize()
        static var codeNullMsg = "Please enter code".localize()
        static var verificationCodeNotValid = "Verification code is not valid".localize()
        static var passwordPolicyValidation = "Password must be minimum 6 characters".localize()
        //and contain at least 1 Alphabet and 1 Number
        static  var passwordEmpty = "Please enter a password".localize()
        static var userNotRegistered = "This phone number is not registered yet".localize()
        static var loginValidation = "mobile number or password is invalid".localize()
        static var cancelError = "Please enter a cancellation reason".localize()
        
        
        
        static var generalFieldValidation = "Field can't be empty".localize()
        static var generalNumberFieldValidation = "Please enter a valid number".localize()
        static var networkError = "Check your internet connection".localize()
        static var somethingWentWrong = "Something went wrong!".localize()
        static var SMSCodeValidation = "Please enter a valid code".localize()
        static var IDNumberValidation = "Please enter a valid ID number".localize()
        static var amountValidation = "Please enter a valid amount".localize()
        static var IDNumberPolicyValidation = "ID number must be 18 digit long".localize()
        static var amountPolicyValidation = "Transfer amount shouldn't exeed current balance".localize()
    }
    
    struct HomeCells {
        static var userDataCell = "UserDataTableViewCell"
        static var userBalanceCell = "UserBalanceTableViewCell"
        static var servicesCell = "ServicesTableViewCell"
    }
    
    struct Pagination {
        static var perPage = 10
    }
    
    struct Pickers{
        static var location = "Test Drive Location".localize()
        static var selectLocation = "Select suitable location for you".localize()
        static var brand = "Car Brand".localize()
        static var selectBrand = "Select suitable brand for you".localize()
        static var model = "New Car Model".localize()
        static var selectModel = "Select suitable model for you".localize()
        static var cameraCarTitle = "Select your car photo".localize()
        static var modelYear = "Car Model Year".localize()
        static var selectYear = "Select your car model year".localize()
        static var inquiryType = "Inquiry Types".localize()
        static var selectInquiryType = "Select your Inquiry Type".localize()
        static var date = "Test Drive Date".localize()
        static var selectDate = "Select your test drive date".localize()
        static var time = "Test Drive Time".localize()
        static var selectTime = "Select your test drive time".localize()
        static var selectBranch = "Select suitable service center for you".localize()
        static var Branch = "Service Centers".localize()
        static var partCategory = "Spare Part Category".localize()
        static var selectPartCategory = "Select your spare part category".localize()
        static var bookingTime = "Booking Time".localize()
        static var selectBookingTime = "Select your booking time".localize()
        static var downPayment = "Down Payment PerCentage".localize()
        static var selectDownPayment = "Select suitable down payment percentage for you".localize()
        static var noOfYeara = "Number Of Years".localize()
        static var selectNoOfYears = "Select suitable number of years for you".localize()
        static var category = "New Car Category".localize()
        static var selectCategory = "Select suitable category for you".localize()
        static var insurance = "Insurance ?".localize()
        static var selectInsurance = "Include Insurance ?".localize()
        static var car = "User Cars".localize()
        static var selectCar = "Select suitable car for you".localize()
    }
    
    struct Tabs {
        static var brandTab = "Brands".localize()
        static var servicesTab = "Services".localize()
        static var showroomTab = "Showroom".localize()
        static var findusTab = "Find Us".localize()
        static var homeTab = "Home".localize()
    }
    
    struct  Cars {
        static var egp = " EGP".localize()
        static var km = " KM".localize()
    }
    
    
    struct Services {
        static var tradeIn = "Trade In".localize()
        static var mansourPlus = "Mansour Plus".localize()
        static var installment = "Installment Calculator".localize()
        static var roadSide = "Road Side Assistance".localize()
        static var warranty = "Extended Warranty".localize()
        static var accessory = "Spare Parts & Accessories".localize()
        static var APlus = "Advance Plus".localize()
        static var offer = "Offers & Promotions".localize()
        static var booking = "Booking Service".localize()
        static var serviceSchedule = "Service Schedule".localize()
        static var Locations = "Locations".localize()
        static var findUs = "Find Us".localize()
        static var carHistory = "Car History".localize()
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
    }
    
    
    struct Booking {
        static var  Completed = "Completed".localize()
        static var  Pending = "Pending".localize()
        static var  Cancelled = "Cancelled".localize()
        static var  Accepted = "Accepted".localize()
        static var  Scheduled = "Scheduled".localize()
    }
    
    
}
