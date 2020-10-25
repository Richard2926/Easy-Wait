import {
    GET_USERS_SUCCESS,
    GET_USERS_ERROR,
    GET_USERS_LOADING,
  } from "../actions/GetUsersActions";
  
  const initialState = {
    success: false,
    loading: false,
    error: {},
    data: {}
  };
  
  const GetUsersReducer = function(state = initialState, action) {
    switch (action.type) {
      case GET_USERS_LOADING: {
        return {
          ...state,
          loading: true
        };
      }
      case GET_USERS_SUCCESS: {
        return {
          ...state,
          success: true,
          loading: false,
          data: action.data
        };
      }
      case GET_USERS_ERROR: {
        return {
          success: false,
          loading: false,
          error: action.data
        };
      }
      default: {
        return state;
      }
    }
  };
  
  export default GetUsersReducer;
  