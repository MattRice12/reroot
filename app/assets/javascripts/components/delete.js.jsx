var Delete = React.createClass({
  handleDelete: function (e) {
    $.ajax({
      url: "/tabs/" + this.props.child.id,
      method: "DELETE",
      dateType: "JSON"
    }).done(function (response) {
      window.location.href="/trees"
    });
  },


  render: function() {
    return (
      <div>
        <span>
          <a className="btn add-del-edit edit" href={"/tabs/" + this.props.child.id + "/edit"} title="Edit Tab">
            <img src={"http://icons.iconarchive.com/icons/designcontest/vintage/72/Pencil-icon.png"} alt="Edit"/>
          </a>
        </span>
        <span>
          <a className="btn add-del-edit add" href={"/tabs/new?parent_tab_id=" + this.props.child.id} title="New Child Tab">
            <img src={"http://icons.iconarchive.com/icons/dryicons/simplistica/48/add-icon.png"} alt="Add"/>
          </a>
        </span>
        <span>
          <a onClick={this.handleDelete} className="btn add-del-edit del" id="delete-tab" title="Delete Tab">
            <img src="http://icons.iconarchive.com/icons/dryicons/simplistica/48/delete-icon.png" alt="Delete Tab" />
          </a>
        </span>
      </div>
    )
  }
});
