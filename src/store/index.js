import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)

import Administrator from './modules/administrator'
import House from './modules/house'
import Migrant from './modules/migrant'
import Opinion from './modules/staff_opinion'
import Problem from './modules/problem'
import Website from './modules/website'
import staff_Inspectation from './modules/staff_Inspectation'
import RoomType from './modules/landlord_roomtype'      
import Room from './modules/landlord_room' 

export default new Vuex.Store({
    modules:{
        Administrator,
        House,
        Migrant,
        staff_Inspectation,
        Opinion,
        Problem,
        Website,
        RoomType,
        Room
    },
})
