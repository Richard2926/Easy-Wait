import FirebaseAuthService from "../../services/firebase/firebaseAuthService";
export const GET_USERS_ERROR = "GET_USERS_ERROR";
export const GET_USERS_SUCCESS = "GET_USERS_SUCCESS";
export const GET_USERS_LOADING = "GET_USERS_LOADING";

export function getUsersData({ users }) {
    
  return dispatch => {
    dispatch({
        type: GET_USERS_LOADING
    });
    FirebaseAuthService.getUsersData(users)
      .then(data => {
        return dispatch({
            type: GET_USERS_SUCCESS,
            data: data,
          });
      })
      .catch(error => {
        return dispatch({
          type: GET_USERS_ERROR,
          payload: error
        });
      });
  };
}

export function moveUser({uid, queue, users}){
  return dispatch => { FirebaseAuthService.moveUser(uid, queue)
      .then((data)=>{
        return dispatch({
          type: GET_USERS_SUCCESS,
          data: data,
        });
      }
        
        //getUsersData(users)
      );
      }
}
