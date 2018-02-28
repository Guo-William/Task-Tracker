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
import $ from "jquery";
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

// Boiler plate code from https://github.com/NatTuck/microblog
// heavily modified to fit my own needs
function update_buttons() {
    $('.manage-button').each((_, bb) => {
        let managee_id = $(bb).data('managee-id');
        let manage = $(bb).data('manages-id');
        if (manage != "") {
            $(bb).text("Un-manage");
        }
        else {
            $(bb).text("Add Managee");
        }
    });
}

function set_button(managee_id, value) {
    $('.manage-button').each((_, bb) => {
        if (managee_id == $(bb).data('managee-id')) {
            $(bb).data('manages-id', value);
        }
    });
    update_buttons();
}

function manage(managee_id) {
    let text = JSON.stringify({
        manage: {
            manager_id: current_user_id,
            managee_id: managee_id
        },
    });

    $.ajax(manage_path, {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: text,
        success: (resp) => {
            set_button(managee_id, resp.data.id);
        },
    });
}

function unmanage(managee_id, manages_id) {
    $.ajax(manage_path + "/" + manages_id, {
        method: "delete",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: "",
        success: () => {
            set_button(managee_id, "");
        },
    });
}

function manage_click(ev) {
    let btn = $(ev.target);
    let manages_id = btn.data('manages-id');
    let managee_id = btn.data('managee-id');

    if (manages_id != "") {
        unmanage(managee_id, manages_id);
    }
    else {
        manage(managee_id);
    }
}

function init_manage() {
    if (!$('.manage-button')) {
        return;
    }

    $(".manage-button").click(manage_click);

    update_buttons();
}

$(init_manage);
