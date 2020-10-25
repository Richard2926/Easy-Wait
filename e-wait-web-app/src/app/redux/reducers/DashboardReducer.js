import {
    DASHBOARD_SUCCESS,
    DASHBOARD_ERROR,
    DASHBOARD_LOADING,
  } from "../actions/DashboardActions";
  
  const initialState = {
    success: false,
    loading: false,
    error: {},
    data: {}
  };
  
  const DashboardReducer = function(state = initialState, action) {
    switch (action.type) {
      case DASHBOARD_LOADING: {
        return {
          ...state,
          loading: true
        };
      }
      case DASHBOARD_SUCCESS: {
        return {
          ...state,
          success: true,
          loading: false,
          data: action.data
        };
      }
      case DASHBOARD_ERROR: {
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
  
  export default DashboardReducer;
  