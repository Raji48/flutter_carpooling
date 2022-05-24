



const REGISTER = "/auth/register";
const LOGIN = "auth/login";
const VERIFY_PHONE_NUMBER = "auth/verify_phone_number";
const RESEND_OTP = "auth/resend_verification_otp";
const FORGET_PASSWORD = "auth/forgot_password";
const VERIFY_RESETPASSOTP ='/auth/verify_otp';
const RESET_PASSWORD = "auth/reset_password_otp";
const PROFILE_DETAILS = "user/";
const CHANGE_PASSWORD = "user/change_password";
const AUTHENTICATED_USER = "user/authenticated_user";
const VERIFY_NEW_NUMBER = "user/verify_phone_number?";
const CHANGE_PHONE_NUMBER = "user/change_phone_number";
const VEHICLE_DETAIL = "user/vehicle";
const PROFILE_PICTURE='http://54.235.130.26:8002/api/user/profile_picture/';


//vehicle owner role
const VEH_OWNER_SHEDULERIDE = "/user/owner/schedule_ride";
const VEH_OWNER_UPCOMING_RIDE = "/user/owner/upcoming_rides";
const VEH_OWNER_PAST_RIDE = "/user/owner/past_rides";
const VEH_OWNER_ACCEPT_REQ = "/user/owner/accept_request";
const VEH_OWNER_REJECT_REQ = "/user/owner/reject_request";
const VEH_OWNER_RESET_REQ = "/user/owner/reset_request_status";

const VEH_OWNER_NOTIFICATION = "/user/owner/fetch_notifications";
const VEH_OWNER_START_RIDE = "/user/owner/start_ride";
const VEH_OWNER_COMPLETE_RIDE = "/user/owner/complete_ride";
const VEH_OWNER_CANCEL_RIDE = "/user/owner/cancel_ride";


const PLACES_LIST = "/user/places?searchTerm";
const SAVEAS_LOCATION="/user/save_location";

// Commuter role flow
const COM_FIND_RIDE = "/user/commuter/find_rides";
const COM_REQ_RIDE= "/user/commuter/request_ride";
const COM_CANCEL_REQ = "/user/commuter/cancel_request";

const COM_NOTIFICATION = "/user/commuter/fetch_notifications";
const COM_REQUESTED_RIDE = "/user/commuter/requested_rides";
const COM_UPCOMING_RIDE = "/user/commuter/upcoming_rides";
const COM_PAST_RIDE = "/user/commuter/past_rides";







