import React, { Component } from "react";
import {
  Grid,
  Card,
  Icon,
  IconButton,
  Tooltip,
} from "@material-ui/core";

const ProjectView = ({theme, roomData, selectProject}) => {
  //console.log(roomData);
  return (
    <Grid container spacing={3} className="mb-24">
      {roomData.map((project, index) => {
        //console.log(project)
        return (<Grid item xs={12} md={6} key={project.id}>
        <Card className="play-card p-sm-24 bg-paper" elevation={6}>
          <div className="flex flex-middle">
            <Icon
              style={{
                fontSize: "44px",
                opacity: 0.6,
                color: theme.palette.primary.main
              }}
            >
              folder
            </Icon>
            <div className="ml-12">
              <h6 className="m-0 mt-4 text-primary font-weight-500">{project.name}</h6>
              <small className="text-muted">{project.queue.length - 1} in line and waiting for {project.done.length - 1} people</small>
            </div>
          </div>
          <Tooltip title="View Details" placement="top">
            <IconButton onClick={() => selectProject(index)}>
              <Icon>arrow_right_alt</Icon>
            </IconButton>
          </Tooltip>
        </Card>
      </Grid>)
      })}
    </Grid>
  );
};

export default ProjectView;
