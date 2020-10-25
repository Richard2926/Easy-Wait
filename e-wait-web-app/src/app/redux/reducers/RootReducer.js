import { combineReducers } from "redux";
import LoginReducer from "./LoginReducer";
import UserReducer from "./UserReducer";
import LayoutReducer from "./LayoutReducer";
import DashboardReducer from "./DashboardReducer";
import GetUsersReducer from "./GetUsersReducer";

const RootReducer = combineReducers({
  login: LoginReducer,
  user: UserReducer,
  layout: LayoutReducer,
  dashboard: DashboardReducer,
  getUsers: GetUsersReducer
});

export default RootReducer;
