
function get_player(){
    var playername = document.getElementById('playernamefield').value;
    var password = document.getElementById('passwordfield').value;

    fetch(`http://0.0.0.0:8080/Signin/playername=${playername}&password=${password}`).then(
        response=>{
            if(!response.ok()){
                throw new Error("");
            }
            else{
                console.log(response.text())
            }
        }
    )
    
  
}