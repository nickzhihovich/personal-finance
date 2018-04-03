import $ from "jquery";

$(document).on('turbolinks:load', function() {
    let categorisPie = document.getElementById('categoris-pie').getContext('2d');
    let categories_titles = JSON.parse($('#categoris-pie').attr('data-titles'));
    let categories_amounts = JSON.parse($('#categoris-pie').attr('data-amounts'));
    let charts_colors = JSON.parse($('#categoris-pie').attr('data-colors'));
    
    Chart.defaults.global.defaultFontSize = 18;
    Chart.defaults.global.defaultFontColor = '#777';

    let massPopChart = new Chart(categorisPie, {
      type:'pie',
      data:{
        labels: categories_titles,
        datasets:[{
          label:'Amount',
          data: categories_amounts,
          backgroundColor: charts_colors,
          borderWidth:1,
          borderColor:'#777',
          hoverBorderWidth:3,
          hoverBorderColor:'#000'
        }]
      },
      options:{
        title:{
          display: false
        },
        legend:{
          display:true,
          position:'right',
          labels:{
            fontColor:'#000'
          }
        },
        layout:{
          padding:{
            left:50,
            right:0,
            bottom:0,
            top:0
          }
        },
        tooltips:{
          enabled:true
        }
      }
    });
});
