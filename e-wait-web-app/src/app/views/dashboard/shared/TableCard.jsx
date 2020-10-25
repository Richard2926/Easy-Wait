import React, { Component } from "react";
import {
  Card,
  Icon,
  IconButton,
  Table,
  TableHead,
  TableRow,
  TableCell,
  TableBody
} from "@material-ui/core";
import { getUsersData, moveUser } from "../../../redux/actions/GetUsersActions"
import { withStyles } from "@material-ui/styles";
import Loading from "../../../../matx/components/MatxLoadable/Loading"
import { connect } from "react-redux";
import PropTypes from "prop-types";
import { withRouter } from "react-router-dom";

class TableCard extends Component {
  state = {
    loading: true,
    success: false,
    usersData: [],
    error: {},
    index: -1,
  };

  componentDidMount() {
    this.props.getUsersData({
      users: this.props.users
    });
  }

  componentWillReceiveProps(nextProps) {

    //console.log(nextProps.getUsers);

    this.setState({
      loading: nextProps.getUsers.loading,
      success: nextProps.getUsers.success,
      usersData: nextProps.getUsers.data,
      error: nextProps.getUsers.error
    })

  }
  changeUserStatus(uid){
    moveUser({
      uid: uid, 
      queue: this.props.room.queue.includes(uid),
      users: this.props.users,
      
    });

    
  }
  render() {
    if(this.state.loading == true || this.state.usersData == null) return <Loading/>;
    return (
          <Card elevation={3} className="pt-20 mb-24">
      <div className="card-title px-24 mb-12">People In line :</div>
      <div className="overflow-auto">
        <Table className="product-table">
          <TableHead>
            <TableRow>
              <TableCell className="px-24" colSpan={4}>
                Name
              </TableCell>
              <TableCell className="px-0" colSpan={2}>
                Position
              </TableCell>
              <TableCell className="px-0" colSpan={2}>
                Status
              </TableCell>
              <TableCell className="px-0" colSpan={1}>
                Action
              </TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {this.state.usersData.map((product, index) => (
              
              <TableRow key={index}>
                <TableCell className="px-0 capitalize" colSpan={4} align="left">
                  <div className="flex flex-middle">
                    <img
                      className="circular-image-small"
                      src={product.url}
                      alt="user"
                    />
                    <p className="m-0 ml-8">{product.name}</p>
                  </div>
                </TableCell>
                <TableCell className="px-0 capitalize" align="left" colSpan={2}>
                {!this.props.room.queue.includes(product.uid) ? (
                      <small className="border-radius-4 bg-primary text-white px-8 py-2 ">
                        -
                      </small>
                  ) : (
                    <small className="border-radius-4 bg-error text-white px-8 py-2 ">
                      {index + 1}
                    </small>
                  )}
                  {product.price > 999
                    ? (product.price / 1000).toFixed(1) + "k"
                    : product.price}
                </TableCell>

                <TableCell className="px-0" align="left" colSpan={2}>
                  {!this.props.room.queue.includes(product.uid) ? (
                      <small className="border-radius-4 bg-primary text-white px-8 py-2 ">
                        Waiting to join
                      </small>
                  ) : (
                    <small className="border-radius-4 bg-error text-white px-8 py-2 ">
                      Currently in Line
                    </small>
                  )}
                </TableCell>
                <TableCell className="px-0" colSpan={1}>
                  <IconButton onClick={() => this.changeUserStatus(product.uid)} >
                    <Icon color="primary">edit</Icon>
                  </IconButton>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>
    </Card>
    );
  }
}
TableCard.propTypes = {
  user: PropTypes.object.isRequired,
  getUsersData: PropTypes.func.isRequired,
  moveUser: PropTypes.func.isRequired,
};

const mapStateToProps = state => ({
  getUsersData: PropTypes.func.isRequired,
  moveUser: PropTypes.func.isRequired,
  user: state.user,
  getUsers: state.getUsers,
});

export default withStyles({}, { withTheme: true })(
  withRouter(
    connect(mapStateToProps, {
      getUsersData,moveUser
    })(TableCard)
  )
);
// const TableCard = ({room}) => {
//   const userList = [
//     {
//       imgUrl: "/assets/images/products/headphone-2.jpg",
//       name: "earphone",
//       price: 100,
//       available: 15
//     },
//     {
//       imgUrl: "/assets/images/products/headphone-3.jpg",
//       name: "earphone",
//       price: 1500,
//       available: 30
//     },
//     {
//       imgUrl: "/assets/images/products/iphone-2.jpg",
//       name: "iPhone x",
//       price: 1900,
//       available: 35
//     },
//     {
//       imgUrl: "/assets/images/products/iphone-1.jpg",
//       name: "iPhone x",
//       price: 100,
//       available: 0
//     },
//     {
//       imgUrl: "/assets/images/products/headphone-3.jpg",
//       name: "Head phone",
//       price: 1190,
//       available: 5
//     }
//   ];

//   return (

//   );
// };

// export default TableCard;
