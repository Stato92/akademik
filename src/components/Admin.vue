<template>
    <b-container>
        <div class="text-center" v-if="logged">
            <h2>Panel administratora</h2>
            <button class="btn-sm btn-primary " v-on:click="logged=false, userInput=''">Wyloguj się</button>
        <div id="dorm-select" v-if="currentDorm==null">
            <label class="m-2" for="select-floor"><h4>Wybierz Akademik:</h4></label>
            <select class="col-2 form-control form-control-sm" id="select-dorm" v-model="currentDorm">
                <option :key="dorm.id" v-bind:value="dorm" v-for="dorm in Db.dorm">
                    {{ dorm.name }}
                </option>
            </select>
        </div>
        <div class="text-center" v-else>
            <h4>{{ currentDorm.name }}
                <small><a href="" v-on:click.prevent="currentDorm=null">(zmień)</a></small>
            </h4>
            <label for="select-floor"><h4>Wybierz piętro:</h4></label>
            <select class="align-self-center col-2 form-control form-control-sm" id="select-floor"
                    v-model="currentFloor">
                <option :key="floor.id" v-bind:value="floor.id" v-for="floor in Db.floor"><span
                        v-if="floor.number == 0">parter</span><span v-else>{{ floor.number }}</span></option>
            </select>
            <template v-if="rooms !== null">
                <div class="custom-control custom-switch" v-for="(room, index) in this.rooms">
                    <input :id="'room-switch'+index" class="custom-control-input" type="checkbox"
                           v-model="room.roomDetails.status">
                    <label :for="'room-switch'+index" class="custom-control-label">{{ room.number }}</label>
                </div>
            </template>
        </div>
        </div>
        <div class="text-center" v-else>
            <b-form-group>
                <label for="password">Wpisz hasło:</label>
                <div class="text-center">
                    <b-form-input id="password" type="password" v-model.lazy="userInput"></b-form-input>
                </div>
            </b-form-group>
        </div>
    </b-container>
</template>

<script>
    import Db from './db.json';

    export default {
        name: "Admin",
        data() {
            return {
                Db,
                currentDorm: null,
                currentFloor: null,
                rooms: null,
                logged: false,
                password: 'haslo123',
                userInput: ''
            }
        },
        watch: {
            currentFloor() {
                this.getRooms();
            },
            rooms() {
                this.rooms.forEach(room => {
                    this.Db.room_details.forEach(function (room_detail, index) {
                            if (room_detail.room_id === room.id) {
                                Db.room_details[index] = room.roomDetails;
                            }
                        }
                    ), this
                }), this;
            },
            userInput() {
                if (this.userInput === this.password) {
                    this.logged = true;
                }
            }
        },
        methods: {
            getRooms() {
                this.rooms = this.Db.room.filter(room => room.floor_id === this.currentFloor && room.type === 0);
                this.rooms.forEach(room => {
                    room.roomDetails = this.Db.room_details.filter(room_details => room_details.room_id === room.id)[0]
                });
            }
        }
    }
</script>

<style scoped>
    #dorm-select {
        text-align: center;
    }

    select {
        margin: 0 auto;
    }
</style>