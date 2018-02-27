// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
import $ from "jquery";

function new_start(t_id){
  var d = new Date();
  var n = d.toISOString();
  let text = JSON.stringify({
    time_block: {
        stime: d,
        etime: "2000-01-01 00:00:00",
        task_id: t_id
      },
  });

  $.ajax(time_block_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => {
      //document.getElementById("tblock_id").value = resp.data.id;
      //console.log(resp.data);
      location.reload();
    },
  });
}

function start_click(ev) {
  let btn = $(ev.target);
  let task_id = btn.data('task-id');

  //console.log(tblock_id);
  new_start(task_id);
}

function update_end(tblock_id,st_time,t_id){
  var d = new Date();
  var n = d.toISOString();
  let text = JSON.stringify({
    id: tblock_id,
    time_block: {
        stime: st_time,
        etime: d,
        task_id: t_id
      },
  });

  $.ajax(time_block_path + "/" + tblock_id, {
    method: "put",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => {
      //document.getElementById("tblock_id").value = resp.data.id;
      //console.log(resp.data);
      location.reload();
    },
  });
}

function stop_click(ev) {
  let btn = $(ev.target);
  let tblock_id = btn.data('tblock-id');
  let task_id = btn.data('task-id');
  let stime = btn.data('stime');
  //console.log("in:"+task_id);
  update_end(tblock_id,stime,task_id);
}

function del_timer(tid){
  $.ajax(time_block_path + "/" + tid, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: () => { location.reload(); },
  });
}

function del_click(ev) {
  let btn = $(ev.target);
  let tblock_id = btn.data('tblock-id');
  //console.log("in:"+task_id);
  del_timer(tblock_id);
}

function update_timer(){
  if (!$("h2").hasClass("update-timeblock")) {
    return;
  }
  //console.log("update timer");
  $(".start-new").click(start_click);
  $(".stop-timer").click(stop_click);
  $(".del-timer").click(del_click);
  //$(".start-task").click(start_click);
  //$(".end-task").click(end_click);
}

$(update_timer);
