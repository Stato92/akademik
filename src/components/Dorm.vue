<template>
    <div id="dorm-floor">
        <div v-if="currentDorm==null">
            <label class="m-2" for="select-floor"><h4>Wybierz Akademik:</h4></label>
            <select class="col-2 form-control form-control-sm" id="select-dorm" v-model="currentDorm">
                <option :key="dorm.id" v-bind:value="dorm" v-for="dorm in Db.dorm">
                    {{ dorm.name }}
                </option>
            </select>
        </div>
        <div v-else>
            <h3><a href="" title="Pokaż więcej informacji" v-on:click.prevent="showDormInfo=!showDormInfo">{{
                currentDorm.name }} </a>
                <small><a href="" v-on:click.prevent="currentDorm=null">(zmień)</a></small>
            </h3>
            <a href="" title="Pokaż więcej informacji" v-on:click.prevent="showDormInfo=!showDormInfo">
                <p>
                    <button class="btn btn-primary btn-sm" v-if="!showDormInfo">Więcej informacji...</button>
                    <button class="btn btn-primary btn-sm" v-else>Mniej informacji</button>
                </p>
            </a>
            <transition enter-active-class="animated fadeInUp"
                        leave-active-class="animated fadeOutDown"
                        name="custom-transition"
            >
                <ul class="text-left" v-if="showDormInfo">
                    <li>adres: {{ currentDorm.address }}</li>
                    <li>opis: {{ currentDorm.description }}</li>
                    <li>email: <a v-bind:href="'mailto:'+currentDorm.email">{{ currentDorm.email }}</a></li>
                    <li>telefon: {{ currentDorm.phone }}</li>
                    <img class="align-self-center" v-bind:src="currentDorm.img" width="600px">
                </ul>
            </transition>
            <label for="select-floor"><h4>Wybierz piętro:</h4></label>
            <select class="align-self-center col-2 form-control form-control-sm" id="select-floor"
                    v-model="currentFloor">
                <option :key="floor.id" v-bind:value="floor.id" v-for="floor in Db.floor"><span
                        v-if="floor.number == 0">parter</span><span v-else>{{ floor.number }}</span></option>
            </select>
            <div id="dorm-floor-image">
                <div id="rooms">
                    <template v-for="(room, index) in getRooms()">
                        <a :key="room.id" href="" v-on:click.prevent="showRoomDetails(room)">
                            <div class="room"
                                 v-bind:class="{'room-top': index<11, 'room-bottom': index>=11, 'room-free': checkRoomStatus(room), 'room-occupied': !checkRoomStatus(room)}"
                                 v-bind:id="'room'+(index+1)"><p class="room-number">{{ room.number }}</p></div>
                        </a>
                    </template>
                </div>
                <transition mode="out-in" name="fade">
                    <div id="room-details" v-if="roomDetails!==null">
                        <a href="" id="room-details-cross" v-on:click.prevent="roomDetails=null"><b>X</b></a>
                        <h3>Informacje o pokoju nr {{ currentRoom }}:</h3>
                        <div v-if="roomDetails!=='Kuchnia'">
                            <ul>
                                <li>Pojemność: {{ roomDetails.capacity }} os.</li>
                                <li>Lodówka: {{ roomDetails.fridge=="1" ? 'JEST' : 'BRAK' }}</li>
                                <li>Wspólna łazienka: {{ roomDetails.shared_bathroom ? 'TAK' : 'NIE' }}</li>
                                <li>Wspólna kuchnia: {{ roomDetails.shared_kitchen ? 'TAK' : 'NIE' }}</li>
                                <li><b>Cena: {{ roomDetails.capacity == "2" ? '555' : '735' }} zł / miesiąc</b></li>
                            </ul>
                            <router-link :aria-disabled="{'true': roomDetails.status==false}" class="btn mt-2"
                                         role="button"
                                         v-bind:class="{'btn-success':roomDetails.status==true, 'btn-danger disabled':roomDetails.status==false }"
                                         v-bind:to="'/rezerwacja/'+currentDorm.name+'/'+currentRoom">
                                {{ roomDetails.status==true ? 'Rezerwuj' : 'Zarezerwowany' }}
                            </router-link>
                        </div>
                        <div v-else>
                            <h4>Kuchnia</h4>
                        </div>
                    </div>
                </transition>
                <img id="dorm-floor-img" src="../assets/floor.jpg"/>
            </div>
        </div>
    </div>
</template>

<script>
    import Db from './db.json';

    export default {
        name: "Dorm",
        methods: {
            getRooms() {
                return this.Db.room.filter(room => room.floor_id == this.currentFloor)
            },
            showRoomDetails(room) {
                this.currentRoom = room.number;
                let room_details = this.Db.room_details.filter(room_details => room_details.room_id === room.id);
                if (room_details.length !== 0) {
                    this.roomDetails = room_details[0];
                } else {
                    this.roomDetails = 'Kuchnia';
                }
            },
            checkRoomStatus(room) {
                let room_details = this.Db.room_details.filter(room_details => room_details.room_id === room.id);
                if (room_details.length !== 0) {
                    return room_details[0].status == true;
                } else {
                    return false;
                }
            }
        },
        data() {
            return {
                Db,
                currentDorm: null,
                showDormInfo: false,
                currentFloor: 1,
                currentRoom: null,
                roomDetails: null
            }
        }
    }
</script>

<style scoped>
    .slide-fade-enter-active {
        transition: all .3s ease;
    }

    .slide-fade-leave-active {
        transition: all .8s cubic-bezier(1.0, 0.5, 0.8, 1.0);
    }

    .slide-fade-enter, .slide-fade-leave-to
        /* .slide-fade-leave-active below version 2.1.8 */
    {
        transform: translateY(50px);
        opacity: 0;
    }
    a:link, a:visited {
        text-decoration: none;
        color: black;
    }

    #dorm-floor {
        border: 1px solid black;
        width: 1280px;
        margin: 10px auto;
        text-align: center;
        padding-bottom: 20px;
    }

    select {
        margin: 0 auto;
    }

    #dorm-floor-image {
        margin-top: 40px;
        text-align: center;
        position: relative;
    }

    #rooms {
        position: absolute;
        top: 18px;
        left: 59px;
        width: 1163px;
        height: 293px;
    }

    #room-details {
        width: 500px;
        height: 250px;
        border: 1px solid black;
        position: absolute;
        left: 390px;
        top: 40px;
        z-index: 3;
        background: rgba(00, 00, 00, 0.8);
    }

    #room-details-cross {
        position: absolute;
        right: 10px;
        top: 5px;
        width: 25px;
        height: 25px;
        z-index: 3;
        background-color: red;
    }

    #room-details > * {
        color: white;
    }

    #room-details > ul {
        text-align: left;
    }

    .room {
        margin: 0;
        padding: 0;
        z-index: 1;
        opacity: 50%;
        border: 1px solid white;
    }

    .room-top {
        position: relative;
        top: 0;
        z-index: 1;
        float: left;
        left: 0;
    }

    .room-bottom {
        position: absolute;
        bottom: 0;
        left: 0;
    }

    .room-free {
        background: rgba(32, 255, 50, 0.3);
    }

    .room-free:hover {
        background: rgba(32, 255, 50, 1);
    }

    .room-occupied {
        background: rgba(255, 99, 71, 0.3);
    }

    .room-occupied:hover {
        background: rgba(255, 99, 71, 1);
    }

    .room-number {
        position: relative;
        top: 40%;
        transform: translateY(-50%);
        font-weight: bold;
    }

    #room1 {
        width: 103px;
        height: 117px;
    }

    #room2 {
        width: 70px;
        height: 117px;
    }

    #room3 {
        width: 89px;
        height: 110px;
    }

    #room4 {
        width: 126px;
        height: 110px;
    }

    #room5 {
        width: 127px;
        height: 110px;
    }

    #room6 {
        width: 128px;
        height: 110px;
    }

    #room7 {
        width: 128px;
        height: 110px;
    }

    #room8 {
        width: 128px;
        height: 110px;
    }

    #room9 {
        width: 88px;
        height: 110px;
    }

    #room10 {
        width: 88px;
        height: 110px;
    }

    #room11 {
        width: 86px;
        height: 110px;
    }

    #room17 {
        width: 100px;
        height: 116px;
    }

    #room16 {
        width: 126px;
        height: 92px;
        left: 178px;
    }

    #room15 {
        width: 122px;
        height: 92px;
        left: 414px;
    }

    #room14 {
        width: 111px;
        height: 93px;
        left: 628px;
    }

    #room13 {
        width: 110px;
        height: 92px;
        left: 848px;
    }

    #room12 {
        width: 130px;
        height: 92px;
        left: 960px;
    }
</style>