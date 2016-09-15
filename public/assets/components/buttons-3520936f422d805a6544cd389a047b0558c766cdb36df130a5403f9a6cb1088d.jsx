// var Buttons = React.createClass({
//
//   handleDelete: function (e) {
//     $.ajax({
//       url: "/tabs/" + this.props.tabID,
//       method: "DELETE",
//       dateType: "JSON"
//     }).done(function (response) {
//
//     });
//   },
//
//   deleteButton: function() {
//     if (this.props.includesProject === true) {
//       return (
//         <a onClick={this.handleDelete} className="btn add-del-edit del" id="delete-tab" title="Delete Tab">
//           <img src="http://icons.iconarchive.com/icons/dryicons/simplistica/48/delete-icon.png" alt="Delete Tab" />
//         </a>
//       )
//     } else {
//       return (<a className="btn add-del-edit del" href={"/tabs/" + this.props.obj.id + "?" + parent_tab_id: params[:parent_tab_id] + child.tree.name.parameterize} data-method="delete" data-confirm="Clicking OK will delete this tab! Are you sure you want to delete this tab?" id: "delete-tab", title: "Delete Tab">
//                 <img src="http://icons.iconarchive.com/icons/dryicons/simplistica/48/delete-icon.png" alt="Delete Tab" />
//               </a>)}
//       )
//     }
//   },
//
//   render: function() {
//     return (
//       <div>
//         <span>
//           <a className="btn add-del-edit edit" href={"/tabs/" + this.props.obj.id + "/edit"} title="Edit Tab">
//             <img src={"http://icons.iconarchive.com/icons/designcontest/vintage/72/Pencil-icon.png"} alt="Edit"/>
//           </a>
//         </span>
//         <span>
//           <a className="btn add-del-edit add" href={"/tabs/new?parent_tab_id=" + this.props.obj.id} title="New Child Tab">
//             <img src={"http://icons.iconarchive.com/icons/dryicons/simplistica/48/add-icon.png"} alt="Add"/>
//           </a>
//         </span>
//         <span>
//           {this.deleteButton}
//         </span>
//       </div>
//     )
//   }
// });
//
//
// <span>
//   <% if request.path.include?("project") %>
//     <%= link_to tab_path(child, parent_tab_id: params[:parent_tab_id], project: request.path, anchor: child.tree.name.parameterize), method: :delete, data: { confirm: 'Clicking OK will delete this tab! Are you sure you want to delete this tab?'}, class: 'btn add-del-edit del', id: "delete-tab", title: "Delete Tab" do %>
//       <%= image_tag("http://icons.iconarchive.com/icons/dryicons/simplistica/48/delete-icon.png") %>
//     <% end %>
//   <% else %>
//     <%= link_to tab_path(child, parent_tab_id: params[:parent_tab_id], anchor: child.tree.name.parameterize), method: :delete, data: { confirm: 'Clicking OK will delete this tab! Are you sure you want to delete this tab?'}, class: 'btn add-del-edit del', id: "delete-tab", title: "Delete Tab" do %>
//       <%= image_tag("http://icons.iconarchive.com/icons/dryicons/simplistica/48/delete-icon.png") %>
//     <% end %>
//   <% end %>
// </span>
//
//
// <div class="creation">
//
//   <%= form_for(Tab.new) do |f| %>
//     <%= f.hidden_field :parent_tab_id, value: child.id %>
//     <%= f.hidden_field :tree_id, value: params.fetch(:tree_id, nil) %>
//
//     <div class="field">
//       <%= f.label :name %>
//       <%= f.text_field :name %>
//     </div>
//
//     <div class="field">
//       <%= f.label :url %>
//       <%= f.text_field :url %>
//     </div>
//
//     <%= f.submit class: "button-primary"%>
//   <% end %>
// </div>
