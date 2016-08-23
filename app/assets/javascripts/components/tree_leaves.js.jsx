// //   My Trees
// ////    Tree Block
// //////    Tree Name
// //////    Tree + Editor
// ////////    Root Tab
// //////////    Name/URL
// //////////    Editor Buttons
// //////////    New Child Tab Form
// ////////////    Children Tabs
  // ////////////      Name/URL
  // ////////////      Editor Buttons
  // ////////////      New Child Tab Form
// //////////////      Children Tabs
//
// var React = require("react");
//
// var TabName = React.createClass({
//   render: function() {
//     <a href={url_with_protocol(tab.url)}>
//       {truncate(tab.name, length: 14)}
//     </a>
//   }
// });
//
//
//
// var CreateTab = React.createClass({
//   render: function() {
//     return (
//       /* CreateTab STUFF */
//     )
//   }
// });
//
// var Tab = React.createClass({
//   render: function() {
//     return (
//       {this.props.tabs.map(function (tab) {
//         return (
//           tab
//         )}
//       )}
//     )
//   }
// });
//
// var TabChild = React.createClass({
//   render: function() {
//     return (
//       <div className="big-block">
//         {this.props.tab.children.map(function (child) {
//           return (
//             <div className="branch">
//               <h3 className="btn leaf">
//                 <a href={this.state.url_with_protocol(tab.url)}>
//                   {truncate(this.props.tab.name, length: 14)}
//                 </a>
//                 <div className="editor">
//                   {
//                     return Buttons
//                   }
//                   <div className="creation">
//                     {
//                       return CreateClass
//                     }
//                   </div>
//                 </div>
//               </h3>
//               {
//                 return <button onClick={<a href={"shared/rechild.html.erb", locals: { children: child.children }}
//                 } if child
//               }
//             </div>
//                     }
//                   }
//                 }
//
//
//
//             child
//           )}
//       )}
//     )
//   }
// });
//
// var Child = React.createClass({
//   render: function() {
//     return (
//       {this.props.child.children.map(function (child) {
//         return (
//           child
//         )}
//       )}
//     )
//   }
// });
//
// {this.props.trees.map(function (tree) {
//   return (
//     tree
//   )}
// )}
//
//
//
// var Name = React.createClass({
//   render: function() {
//     return ({this.props.tab.name})
//   }
// });
//
//
// var CurrentUser = React.createClass({
//   getInitialState: function () {
//     return {
//       this.props.current_user
//     }
//   }
// });
//
// var Tree = React.createClass({
//   render: function () {
//     return {
//       this.props.tree
//     }
//   }
// });
//
// var Tabs = React.createClass({
//   render: function () {
//     return {
//       {this.props.trees.map(function (tree) {
//         return (
//           tree
//         )}
//       )}
//       tabs: Tree.tabs({
//         render: function() {
//           if (this.props.parent.nil?) {
//             return (<div className="trunk" id="root">
//               <h3 className="btn leaf">
//                 <a href={this.state.url_with_protocol(tab.url)}> {truncate(this.props.tab.name, length: 14) </a>
//                   <div className="editor">
//                     {return <button onClick={_.partial(this.)
//
//                     }
//                   }
//                 }
//               )
//             }
//           }
//         }
//       )
//     }
//   },
// });
//
//   render: function() {
//     return (
//       <div className="grove">
//         {this.props.tabs.map(function (tab) {
//           return (
//             <
//
//           )
//         }}
//         ____
//
//     );
//   }
// });
//
//
//
//
//                   <%= render "shared/buttons_tabs.html.erb", obj: tab %>
//                   <div className="creation">
//                     <%= render "shared/create_tab.html.erb", obj: tab %>
//                   </div>
//                 </div>
//               </h3>
//
//               <div className="big-block">
//                 <% tab.children.each do |child| %>
//                     <div className="branch">
//                       <h3 className="btn leaf"><%= link_to truncate(child.name, length: 14), url_with_protocol(child.url) %>
//                         <div className="editor">
//                           <%= render "shared/buttons_tabs.html.erb", obj: child %>
//                           <div className="creation">
//                             <%= render "shared/create_tab.html.erb", obj: child %>
//                           </div>
//                         </div>
//                       </h3>
//                         <%= render( partial: 'shared/rechild', locals: { children: child.children }) if child %>
//                     </div>
//                 <% end %>
//               </div>
//             </div>
//           <% end %>
//         <% end %>
//       </div>
//     );
//   }
// });
