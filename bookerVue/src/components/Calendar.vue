<template>
    <div>
          <p class="rooms">
            <button v-for="(room,index) in rooms" v-on:click="selectRoom(index)" 
            :class="{selBtn: room.id == selRoom.id}">
              {{room.name}}
            </button>
          </p>
          <p>
            Boardroom is: <b>{{selRoom.name}}</b>
          </p>

        <div>
            <div>
                <div>
                    <p><button v-on:click="prevMonth()">&lt;</button>
                    {{getMonth[currentMonth]}} {{currentYear}}
                    <button v-on:click="nextMonth()">&gt;</button></p>
                </div>
                <div class="table table-active col-md-offset-6 col-md-6">
                    <table>
                        <tr>
                            <th v-for="weekday in getDays">{{weekday}}</th>
                        </tr>
                        <tr v-for="week in weeks">
                            <td v-for="day in week" :class="{date: day.findDay == currentDay}">
                                {{day.findDay}}</td>  
                        </tr>
                    </table>
            </div>
            </div>
            <div class="col-md-offset-3 col-md-6">
                <div>
                    <button v-if="weekDays == 'sun'" v-on:click="ruWeek()">RU Week</button>
                    <button v-else-if="weekDays == 'mon'" v-on:click="enWeek()">EN Week</button>
                </div>
            </div>

        </div>
          <div>
          </div>
    </div>
</template>

<script>
import axios from 'axios'
    export default {
        name: 'calendar',
        props: ['user'],
        data () {
    return {
            errorMsg: '',
            date: new Date(),
            weeks: [],
            currentMonth: '',
            currentYear: '',
            weekDays: 'sun',
      rooms: [],
      selRoom: {
        id: '2',
        name: ''
      },
        }
    },
            methods:{
selectRoom: function(index){
      var self = this
      self.selRoom = self.rooms[index]
    },
    getRooms: function(){
      var self = this

//           axios.get(getUrl() + 'rooms/' + self.user + '/id_user/' + self.id)
axios.get(getUrl() + 'rooms/Boardroom 1/id_user/2')
          .then(function (response) {
          if (Array.isArray(response.data))
          {
            self.rooms = response.data
            if (!localStorage['room'])
            {
              self.selRoom = self.rooms[0]
            }
            else
            {
              self.selRoom = JSON.parse(localStorage['room'])
            }
          }
          else{
            self.errorMsg = response.data
          }
      })
      .catch(function (error) {
        console.log(error)
      })
    },
                getMonthYear: function()
            {
                    var self = this
                    self.currentMonth = self.date.getMonth()
                    self.currentYear = self.date.getFullYear()
            },
                    rowsCalendar: function(){
                            var self = this
                            self.weeks = []
                            var date = new Date(self.currentYear, self.currentMonth)
                            self.weeks[0] = []
                            for (var i = 0; i < self.getNumDay(date); i++)
                        {
                            self.weeks[0].push({})
                        }
                             var count = 0
                             while (date.getMonth() == self.currentMonth)
                        {
                            self.weeks[count].push({findDay: date.getDate()})
                                    if (self.getNumDay(date) % 7 == 6)
                            {
                                 count++
                                 self.weeks[count] = []
                            }
                            date.setDate(date.getDate() + 1)
                        }
                    },
                    getNumDay: function(date){
                                var self = this
                                var numDay = date.getDay()
                                if (self.weekDays == 'mon')
                        {
                            if (numDay == 0)
                            {
                                numDay = 7
                            }
                            return numDay - 1
                        }
                        if (self.weekDays == 'ru')
                        {
                            if (numDay == 0)
                            {
                                numDay = 7
                            }
                            return numDay - 1
                        }
                        else
                        {
                            return numDay
                        }
                    },
                     prevMonth: function(){
                        var self = this
                          self.currentMonth -= 1
                          if (self.currentMonth < 0){
                                self.currentMonth = 11
                                self.currentYear -= 1
                        }
                        self.rowsCalendar()
                    },
                   nextMonth: function(){
                        var self = this
                        self.currentMonth += 1
                        if (self.currentMonth > 11)
                        {
                             self.currentMonth = 0
                             self.currentYear += 1
                        }
                        self.rowsCalendar()

                    },
                   enWeek: function(){
                        var self = this
                        self.weekDays = 'sun'
                         self.rowsCalendar()
                    },
                     ruWeek: function(){
                        var self = this
                        self.weekDays = 'mon'
                        self.rowsCalendar()
                    }
            },
            computed: {
                getDays(){
                    var self = this
                    return getWeekDays(self.weekDays)
                },
                        getMonth(){
                    var self = this
                     return getNameMonth()
                },
                     currentDay(){
                    var self = this
                    if (self.date.getMonth() == self.currentMonth
                                && self.date.getFullYear() == self.currentYear)
                    {
                        return self.date.getDate()
                    }
                    else
                    {
                        return false
                    }
                },
            },
            created(){
                this.getMonthYear()
                this.getRooms()
                this.rowsCalendar()
        }
 }
</script>

<style>
    .table{
        width: 70%;
        padding-left: 300px;
    }
    
    td{
        width: 90px;
        height: 90px;
        text-align: center;
    }
    
    
</style>