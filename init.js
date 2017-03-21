var initVoice = function() {
if (annyang) {
        
    // Set default values
    Shiny.onInputChange('loadTable', null);
    Shiny.onInputChange('loadPlot', null);
    Shiny.onInputChange('filterVar', null);
    Shiny.onInputChange('filterVal', null);
    Shiny.onInputChange('plotvar', null);

  var commands = {
    'load data': function(){
        Shiny.onInputChange('loadTable', 1);
    },
    'show plot': function(){
        Shiny.onInputChange('showPlot', 1);
    },
    
    'filter :variable = :value': function(variable, value){
        Shiny.onInputChange('filterVar', variable.toLowerCase());
        Shiny.onInputChange('filterVal', value.toLowerCase());
    },
    
    'plot :variable': function(variable){
        Shiny.onInputChange('plotvar', variable.toLowerCase());
    },
    
    'show list': showModal,
    
    'hide list': hideModal,
    
    'reset': function(){
        Shiny.onInputChange('verb', null);
        Shiny.onInputChange('param1', null);
        Shiny.onInputChange('val1', null);
        Shiny.onInputChange('plotvar', null);
    }
  };

  annyang.addCommands(commands);
  
  annyang.addCallback('resultMatch', function(userSaid, commandText, phrases) {
    //console.log(userSaid); // sample output: 'hello'
    //console.log(commandText); // sample output: 'hello (there)'
    //console.log(phrases); // sample output: ['hello', 'halo', 'yellow', 'polo', 'hello kitty']
    $(".userSpeech").html("You said: " + phrases[0] +".");
  });

  annyang.addCallback('resultNoMatch', function(phrases) {
    //console.log("I think the user said: ", phrases[0]);
    //console.log("But then again, it could be any of the following: ", phrases);
    $(".userSpeech").html("Oops, it sounds like you said: " + phrases[0] + 
    ". Please try again or say 'show list' for more options.");
    //$(".userSpeech").html("But then again, it could be any of the following: " + phrases);
  });

  annyang.setLanguage('en-NZ');
  annyang.start();
  }
};

var showModal = function() {
   $('#commands_modal').modal('show');
};
var hideModal = function() {
   $('#commands_modal').modal('hide');
};

$(function() {
  setTimeout(initVoice, 10);
});