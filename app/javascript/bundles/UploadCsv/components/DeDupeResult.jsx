
import React from 'react';

const HdrRow = () => {
	return(<tr>
	  <th>First</th>
	  <th>Last</th>
	  <th>Address</th>
	  <th>City</th>
	  <th>Company</th>
	  <th>Email</th>
	  <th>Phone</th>
	  <th>State</th>
	  <th>State</th>
	  <th>Zip</th>
	</tr>)
}

const Row = (props) => {
  return(
  <tr key={props.ky}>
    <td>{props.row.first_name}</td>
    <td>{props.row.last_name}</td>
    <td>{props.row.address1}</td>
    <td>{props.row.city}</td>
    <td>{props.row.company}</td>
    <td>{props.row.email}</td>
    <td>{props.row.phone}</td>
    <td>{props.row.state}</td>
    <td>{props.row.state_long}</td>
    <td>{props.row.zip}</td>
  </tr>)

}

const Rows = (props) => {	
   var rows =[];

   rows.push(props.rows.map((row, ky) => {
     return(<Row key={ky} ky={ky} row={row} />)
   }))
   var tab_ky = props.ky || null;

   return(
   	<table key={tab_ky} className={"table table-striped"}>
	      <tbody>
	        <HdrRow/>
	        {rows}
		  	</tbody>
    	</table>)
}; 

export default class DeDupeResult extends React.Component {

  	constructor(props) {
   	 super(props);
   	 this.getRows = this.getRows.bind(this);
    	this.toggleDisplay = this.toggleDisplay.bind(this);
    	this.state = {display_dupes: true};
  	}

  	toggleDisplay() {
  		var show_dupes = !this.state.display_dupes;
    	this.setState({display_dupes: show_dupes})
  	}

	getRows() {
  		if (this.state.display_dupes) {
  			var tables = []; 
	   	tables.push(this.props.data.dup.map((dup_ar,ky) => {   
	   		return(<div key={ky} className={'dupe-container'}> 
	       	      <Rows rows={dup_ar} key={ky} ky={ky}/>
	       	      </div>) 
	   	}))
	   
	  		return(
	  			<div>
	  			  <h3> Duplicate Rows </h3>
	  			  {tables}
	  			</div>
	  			)
	  	}
	  	else {
	  		var rows = [];
	  		var uniq = this.props.data.uniq.sort((a,b) => (a.last_name > b.last_name) ? 1 : ((b.last_name > a.last_name) ? -1 : 0));
	  	    //rows.push(this.props.data.uniq.map((row,ky) => (
	  	   	//  <Row key={ky} row={row}/>
	        //)))
	  		return(
	  			<div>
	           <h3> Unique Rows </h3>
	  			  <Rows rows={uniq}/>
	  			</div>)
	  	}
	}
  

	render() {
	  	var show_dupes = this.state.display_dupes;
	  	var rows = this.getRows();
	  	return(
	  	<div>
			<div className={"btn-group btn-group-toggle"} data-toggle="buttons">
			  <label className={"display-selector btn btn-secondary " + (show_dupes ? 'active' : '')}>
			    <input type="radio" name="options" id="option1"
			    onClick={this.toggleDisplay} 
			    autoComplete={"off"} defaultChecked={show_dupes}/> Duplicates
			  </label>
			  <label className={"display-selector btn btn-secondary " + (show_dupes ? '' : 'active')}>
			    <input type="radio" name="options" 
			    onClick={this.toggleDisplay} 
			    id="option2" autoComplete={"off"} defaultChecked={!show_dupes}/> Unique
			  </label>
			</div>
	  	    { rows }
	  	</div>
	    )
	  }

	}