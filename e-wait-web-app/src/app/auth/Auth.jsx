import React, { Component, Fragment } from "react";
import { connect } from "react-redux";
import { PropTypes } from "prop-types";
import { setUserData } from "../redux/actions/UserActions";
import firebaseAuthService from "../services/firebase/firebaseAuthService";
import history from "history.js";

class Auth extends Component {
  state = {};
  
  constructor(props) {
    //console.log(props);
    super(props);
    this.checkFirebaseAuth();

  }

  checkFirebaseAuth = async () => {
    firebaseAuthService.checkAuthStatus(user => {
      if (user) {
        //console.log(user.uid);
        //console.log(user.email);
        //console.log(user.emailVerified);
        firebaseAuthService.getUserData().then((userData) => {
          console.log(userData);
          this.props.setUserData({
            ...user,
              role: "ADMIN",
              ...userData
              });
              history.push({
                pathname: "/"
              });
        });
        
        
      } else {
        console.log("not logged in");
        history.push({
          pathname: "/session/signin"
        });
      }
    });
  };

  render() {
    const { children } = this.props;
    return <Fragment>{children}</Fragment>;
  }
}

const mapStateToProps = state => ({
  setUserData: PropTypes.func.isRequired,
  login: state.login
});

export default connect(
  mapStateToProps,
  { setUserData }
)(Auth);
