<template>
    <b-container>
        <h2 class="text-center">Panel administratora</h2>
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
                <div class="custom-control custom-switch" v-for="room in this.rooms">
                    <input class="custom-control-input" id="customSwitch1" type="checkbox"
                           v-bind:value="room.roomDetails.status">
                    <label class="custom-control-label" for="customSwitch1">{{ room.number }}</label>
                </div>
            </template>
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
                rooms: null
            }
        },
        watch: {
            currentFloor() {
                this.getRooms();
            }
        },
        methods: {
            getRooms() {
                this.rooms = this.Db.room.filter(room => room.floor_id === this.currentFloor);
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