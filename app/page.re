open My_lib;

[@react.component]
let default = () => {
  let timesClicked = Lib.read();
  <div>
    <My_client_component />
    <Increment_button timesClicked />
    <p>
      {React.string("Clicked increment ")}
      {React.int(timesClicked)}
      {React.string(" times!")}
    </p>
  </div>;
};

// render components based on data from my database
// send updates to my database
