import React, { Component, Fragment } from "react";
import {
  Grid,
  Card
} from "@material-ui/core";

import DoughnutChart from "../charts/echarts/Doughnut";
import ModifiedAreaChart from "./shared/ModifiedAreaChart";
import ProjectView from "./shared/ProjectView";
import TableCard from "./shared/TableCard";
import RowCards from "./shared/RowCards";
import StatCards2 from "./shared/StatCards2";
import UpgradeCard from "./shared/UpgradeCard";
import Campaigns from "./shared/Campaigns";
import { withStyles } from "@material-ui/styles";
import { connect } from "react-redux";
import PropTypes from "prop-types";
import { withRouter } from "react-router-dom";
import Loading from "../../../matx/components/MatxLoadable/Loading"
import {getDashboardData} from "../../redux/actions/DashboardActions"

class Dashboard1 extends Component {

  state = {
    loading: true,
    success: false,
    dashboardData: [],
    error: {},
    index: -1,
  };
  constructor(props){
    super(props);
    this.state = {
      loading: true,
      success: false,
      dashboardData: [],
      error: {},
      index: -1,
    };
    this.selectProject = this.selectProject.bind(this);
  }
  componentDidMount() {
    this.props.getDashboardData({
      uid: this.props.user.uid
    });
  }

  componentWillReceiveProps(nextProps) {

    console.log(nextProps.dashboard);

    this.setState({
      loading: nextProps.dashboard.loading,
      success: nextProps.dashboard.success,
      dashboardData: nextProps.dashboard.data,
      error: nextProps.dashboard.error
    })

  }

  selectProject(index) {
    this.setState({
      index: index
    })
  }

  render() {

    let { theme, user } = this.props;

    if(this.state.loading == true || this.state.dashboardData == null) return <Loading/>;

    return (
      <Fragment>
        <div className="pb-86 pt-30 px-30 bg-primary">
          {/* <ModifiedAreaChart
            height="280px"
            option={{
              series: [
                {
                  data: [34, 45, 31, 45, 31, 43, 26, 43, 31, 45, 33, 40],
                  type: "line"
                }
              ],
              xAxis: {
                data: [
                  "Jan",
                  "Feb",
                  "Mar",
                  "Apr",
                  "May",
                  "Jun",
                  "Jul",
                  "Aug",
                  "Sep",
                  "Oct",
                  "Nov",
                  "Dec"
                ]
              }
            }}
          ></ModifiedAreaChart> */}
        </div>
        {/* <div className="pb-86 pt-30 px-30 bg-primary"></div> */}
        <div className="analytics m-sm-30 mt--72">
          <Grid container spacing={3}>
          <ProjectView theme={theme} roomData={this.state.dashboardData.rooms} selectProject={this.selectProject}/>
          {this.state.index > -1 &&
        <TableCard room={this.state.dashboardData.rooms[this.state.index]} users = {[...this.state.dashboardData.rooms[this.state.index].done,
        ...this.state.dashboardData.rooms[this.state.index].queue]} />
      }
          
            <Grid item lg={8} md={8} sm={12} xs={12}>

              
            </Grid>
          </Grid>
        </div>
      </Fragment>
    );
  }
}



Dashboard1.propTypes = {
  user: PropTypes.object.isRequired,
  getDashboardData: PropTypes.func.isRequired,
};

const mapStateToProps = state => ({
  getDashboardData: PropTypes.func.isRequired,
  user: state.user,
  dashboard: state.dashboard,
});

export default withStyles({}, { withTheme: true })(
  withRouter(
    connect(mapStateToProps, {
      getDashboardData
    })(Dashboard1)
  )
);
