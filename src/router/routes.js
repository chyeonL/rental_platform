const Login = ()=>import('@/views/Login')

// staff
const Staff = ()=>import('@/views/Staff')
// const SHome = ()=>import('@/views/Staff/Home')
const SMy = ()=>import('@/views/Staff/My')
const SWebsite = ()=>import('@/views/Staff/Website/index.vue')
const SHouse = ()=>import('@/views/Staff/House')     // 出租屋
const SHouse_All = ()=>import('@/views/Staff/House/All.vue')
const SHouse_New = ()=>import('@/views/Staff/House/New.vue')
const SHouse_Detail = ()=>import('@/views/Staff/House/Detail.vue')
const Migrant = ()=>import('@/views/Staff/Migrant') // 流动人员
const Migrant_All = ()=>import('@/views/Staff/Migrant/All.vue')
const Migrant_New = ()=>import('@/views/Staff/Migrant/New.vue')
const Migrant_Detail = ()=>import('@/views/Staff/Migrant/Detail.vue')
const Inspectation = ()=>import('@/views/Staff/Inspectation')       // 安全检查
const Inspectation_All = ()=>import('@/views/Staff/Inspectation/All.vue') 
const Inspectation_New = ()=>import('@/views/Staff/Inspectation/New.vue')
const Inspectation_Detail = ()=>import('@/views/Staff/Inspectation/Detail.vue')
const SOpinion = ()=>import('@/views/Staff/Opinion/index.vue')                 // 意见反馈
const SOpinion_All = ()=>import('@/views/Staff/Opinion/All.vue')
const SOpinion_Detail = ()=>import('@/views/Staff/Opinion/Detail.vue')



// landlord
const Landlord = ()=>import('@/views/Landlord')
const LHome = ()=>import('@/views/Landlord/Home')
const Contract = ()=>import('@/views/Landlord/Contract')    // 合同
const Contract_All = ()=>import('@/views/Landlord/Contract/All.vue')
const Contract_New = ()=>import('@/views/Landlord/Contract/New.vue')
const Contract_Detail = ()=>import('@/views/Landlord/Contract/Detail.vue')
const House = ()=>import('@/views/Landlord/House')  
const House_Room_All = ()=>import('@/views/Landlord/House/Room/All.vue')    // 房间
const House_Room_New = ()=>import('@/views/Landlord/House/Room/New.vue')
const House_Room_Detail = ()=>import('@/views/Landlord/House/Room/Detail.vue')
const House_Type_All = ()=>import('@/views/Landlord/House/Type/All.vue')    // 房型
const House_Type_New = ()=>import('@/views/Landlord/House/Type/New.vue')
const House_Type_Detail = ()=>import('@/views/Landlord/House/Type/Detail.vue')
const Rent = ()=>import('@/views/Landlord/Rent')
const Rent_All = ()=>import('@/views/Landlord/Rent/All.vue')    // 月租
const Rent_New = ()=>import('@/views/Landlord/Rent/New.vue')
const Rent_Detail = ()=>import('@/views/Landlord/Rent/Detail.vue')
const Tenant = ()=>import('@/views/Landlord/Tenant')
const Tenant_All = ()=>import('@/views/Landlord/Tenant/All.vue')    // 租户
const Tenant_New = ()=>import('@/views/Landlord/Tenant/New.vue')
const Tenant_Detail = ()=>import('@/views/Landlord/Tenant/Detail.vue')
const LOpinion = ()=>import('@/views/Landlord/Opinion')
const LOpinion_All = ()=>import('@/views/Landlord/Opinion/All.vue')    // 意见
const LOpinion_New = ()=>import('@/views/Landlord/Opinion/New.vue')
const LOpinion_Detail = ()=>import('@/views/Landlord/Opinion/Detail.vue')
const LWebsite = ()=>import('@/views/Landlord/Website')      // 网站
const LMy = ()=>import('@/views/Landlord/My')      // 我的

// website
const HomePage = ()=>import('@/views/HomePage')

export default [
    // login
    {
        path:'/login',
        name:'Login',
        component:Login         
    },
    // staff
    {
        path:'/staff',
        name:'Staff',
        component:Staff,
        redirect:'/staff/house/all',
        meta:{
            requireAuth:true
        },
        children:[
            {   // 出租屋
                path:'house',
                name:'SHouse',
                component:SHouse,
                children:[
                    {
                        path:'all',
                        name:'SHouse_All',
                        component:SHouse_All
                    },
                    {
                        path:'new',
                        name:'SHouse_New',
                        component:SHouse_New
                    },
                    {
                        path:'detail',
                        name:'SHouse_Detail',
                        component:SHouse_Detail
                    },
                ]
            },
            {   // 流动人员
                path:'migrant',
                name:'Migrant',
                component:Migrant,
                children:[
                    {
                        path:'all',
                        name:'Migrant_All',
                        component:Migrant_All
                    },
                    {
                        path:'detail',
                        name:'Migrant_Detail',
                        component:Migrant_Detail
                    },
                ]
            }, 
            {   // 安全检查
                path:'inspectation',
                name:'Inspectation',
                component:Inspectation,
                children:[
                    {
                        path:'all',
                        name:'allInspectation',
                        component:Inspectation_All
                    },
                    {
                        path:'new',
                        name:'newInspectation',
                        component:Inspectation_New
                    },
                    {
                        path:'detail',
                        name:'DetailInspectation',
                        component:Inspectation_Detail
                    },
                ]
            },          
            {   // 意见反馈
                path:'opinion',
                name:'Opinion',
                component:SOpinion,
                children:[
                    {
                        path:'all',
                        name:'SOpinion_All',
                        component:SOpinion_All
                    },
                    {
                        path:'detail',
                        name:'SOpinion_Detail',
                        component:SOpinion_Detail
                    }
                ]
            },
            {   // 我的
                path:'my',
                name:'SMy',
                component:SMy
            },
            {   // 网站设置
                path:'website',
                name:'SWebsite',
                component:SWebsite
            }
        ]
    }, 
    // landlord
    {
        path:'/landlord',
        name:'Landlord',
        component:Landlord,
        redirect:'/landlord/home',
        meta:{
            requireAuth:true
        },
        children:[
            {   // 首页
                path:'home',
                name:'LHome',
                component:LHome
            },
            {   // 签署合同
                path:'contract',
                name:'Contract',
                component:Contract,
                children:[
                    {
                        path:'all',
                        name:'Contract_All',
                        component:Contract_All
                    },
                    {
                        path:'new',
                        name:'Contract_New',
                        component:Contract_New
                    },
                    {
                        path:'detail',
                        name:'Contract_Detail',
                        component:Contract_Detail
                    }
                ]
            },
            {   // 出租房
                path:'house',
                name:'House',
                component:House,
                children:[
                    {
                        path:'room/all',
                        name:'allRooms',
                        component:House_Room_All
                    },
                    {
                        path:'room/new',
                        name:'newRoom',
                        component:House_Room_New
                    },
                    {
                        path:'room/detail',
                        name:'DetailRoom',
                        component:House_Room_Detail
                    },
                    {
                        path:'type/all',
                        name:'allTypes',
                        component:House_Type_All
                    },
                    {
                        path:'type/new',
                        name:'newType',
                        component:House_Type_New
                    },
                    {
                        path:'type/detail',
                        name:'DetailType',
                        component:House_Type_Detail
                    }
                ]
            },
            {   // 租客
                path:'tenant',
                name:'Tenant',
                component:Tenant,
                children:[
                    {
                        path:'all',
                        name:'Tenant_All',
                        component:Tenant_All
                    },
                    {
                        path:'new',
                        name:'Tenant_New',
                        component:Tenant_New
                    },
                    {
                        path:'detail',
                        name:'Tenant_Detail',
                        component:Tenant_Detail
                    }
                ]
            },
            {   // 月租
                path:'rent',
                name:'Rent',
                component:Rent,
                children:[
                    {
                        path:'all',
                        name:'Rent_All',
                        component:Rent_All
                    },
                    {
                        path:'new',
                        name:'Rent_New',
                        component:Rent_New
                    },
                    {
                        path:'detail',
                        name:'Rent_Detail',
                        component:Rent_Detail
                    }
                ]
            },
            {   // 意见
                path:'opinion',
                name:'LOpinion',
                component:LOpinion,
                children:[
                    {
                        path:'all',
                        name:'LOpinion_All',
                        component:LOpinion_All
                    },
                    {
                        path:'new',
                        name:'LOpinion_New',
                        component:LOpinion_New
                    },
                    {
                        path:'detail',
                        name:'LOpinion_Detail',
                        component:LOpinion_Detail
                    }
                ]
            },
            {   // 网站
                path:'website',
                name:'LWebsite',
                component:LWebsite
            },
            {   // 设置
                path:'my',
                name:'LMy',
                component:LMy
            },
        ]
    },
    // website
    {
        path:'',
        name:'HomePage',
        component:HomePage
    }
]