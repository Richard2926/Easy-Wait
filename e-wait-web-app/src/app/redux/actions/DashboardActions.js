import FirebaseAuthService from "../../services/firebase/firebaseAuthService";
export const DASHBOARD_ERROR = "DASHBOARD_ERROR";
export const DASHBOARD_SUCCESS = "DASHBOARD_SUCCESS";
export const DASHBOARD_LOADING = "DASHBOARD_LOADING";

export function getDashboardData({ uid }) {
    
  return dispatch => {
    dispatch({
        type: DASHBOARD_LOADING
    });
    FirebaseAuthService.getDashboardData(uid)
      .then(data => {
        //console.log("data")
        return dispatch({
            type: DASHBOARD_SUCCESS,
            data: data,
          });
      })
      .catch(error => {
        return dispatch({
          type: DASHBOARD_ERROR,
          payload: error
        });
      });
  };
}
