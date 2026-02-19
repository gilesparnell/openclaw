'use client';

import React, { useState, useEffect } from 'react';
import { 
  Activity, 
  CheckCircle2, 
  Clock, 
  Users, 
  FileText, 
  MessageSquare,
  ArrowRight,
  Bot,
  Target,
  BarChart3,
  RefreshCw
} from 'lucide-react';

// Types
interface Agent {
  id: string;
  name: string;
  role: string;
  status: 'idle' | 'active' | 'completed' | 'blocked';
  currentTask: string;
  lastActivity: string;
  color: 'green' | 'blue' | 'amber';
  icon: React.ReactNode;
}

interface Task {
  id: string;
  title: string;
  agentId: string;
  status: 'inbox' | 'in_progress' | 'review' | 'done';
  createdAt: string;
  description?: string;
}

interface ActivityItem {
  id: string;
  type: 'task_started' | 'task_completed' | 'message' | 'file_created';
  agentName: string;
  message: string;
  timestamp: string;
}

// Mock Data
const AGENTS: Agent[] = [
  {
    id: 'fury',
    name: 'Fury',
    role: 'Lead Qualification Analyst',
    status: 'active',
    currentTask: 'Researching AI receptionist competitors',
    lastActivity: '2 mins ago',
    color: 'green',
    icon: <Target className="w-5 h-5" />
  },
  {
    id: 'friday',
    name: 'Friday',
    role: 'Voice/SMS Workflow Architect',
    status: 'active',
    currentTask: 'Designing tradie workflow',
    lastActivity: '5 mins ago',
    color: 'blue',
    icon: <Bot className="w-5 h-5" />
  },
  {
    id: 'loki',
    name: 'Loki',
    role: 'Content & SEO Strategist',
    status: 'active',
    currentTask: 'Writing blog post',
    lastActivity: '3 mins ago',
    color: 'amber',
    icon: <FileText className="w-5 h-5" />
  }
];

const TASKS: Task[] = [
  {
    id: '1',
    title: 'Competitive Analysis: AI Receptionist Market',
    agentId: 'fury',
    status: 'in_progress',
    createdAt: '2026-02-06',
    description: 'Research Dialpad, Smith.ai, Ruby Receptionists'
  },
  {
    id: '2',
    title: 'Go High Level Workflow for Tradies',
    agentId: 'friday',
    status: 'in_progress',
    createdAt: '2026-02-06',
    description: 'Voice scripts, SMS sequences, lead capture'
  },
  {
    id: '3',
    title: 'Blog Post: Tradies Missed Calls',
    agentId: 'loki',
    status: 'in_progress',
    createdAt: '2026-02-06',
    description: 'SEO-optimized content with CTA'
  }
];

const ACTIVITIES: ActivityItem[] = [
  {
    id: '1',
    type: 'task_started',
    agentName: 'Fury',
    message: 'Started competitive analysis research',
    timestamp: '2 mins ago'
  },
  {
    id: '2',
    type: 'task_started',
    agentName: 'Friday',
    message: 'Designing Go High Level workflow',
    timestamp: '5 mins ago'
  },
  {
    id: '3',
    type: 'task_started',
    agentName: 'Loki',
    message: 'Writing blog post content',
    timestamp: '3 mins ago'
  }
];

// Components
function AgentCard({ agent }: { agent: Agent }) {
  const colorClasses = {
    green: 'border-green-500/30 hover:border-green-500/60 bg-green-900/10',
    blue: 'border-blue-500/30 hover:border-blue-500/60 bg-blue-900/10',
    amber: 'border-amber-500/30 hover:border-amber-500/60 bg-amber-900/10'
  };

  const iconColors = {
    green: 'text-green-400 bg-green-900/30',
    blue: 'text-blue-400 bg-blue-900/30',
    amber: 'text-amber-400 bg-amber-900/30'
  };

  const statusColors = {
    idle: 'text-gray-400',
    active: 'text-green-400',
    completed: 'text-blue-400',
    blocked: 'text-red-400'
  };

  return (
    <div className={`group relative overflow-hidden bg-gray-900 border rounded-2xl p-6 transition-all duration-300 hover:shadow-2xl hover:-translate-y-1 ${colorClasses[agent.color]}`}>
      <div className="relative z-10">
        <div className="flex items-center justify-between mb-4">
          <div className={`w-12 h-12 rounded-xl flex items-center justify-center ${iconColors[agent.color]}`}>
            {agent.icon}
          </div>
          <div className={`flex items-center gap-2 text-sm font-medium ${statusColors[agent.status]}`}>
            <span className="w-2 h-2 rounded-full bg-current animate-pulse"></span>
            {agent.status.charAt(0).toUpperCase() + agent.status.slice(1)}
          </div>
        </div>
        
        <h3 className="text-xl font-bold text-white mb-1 group-hover:text-gray-200 transition-colors">
          {agent.name}
        </h3>
        <p className="text-gray-400 text-sm mb-4">{agent.role}</p>
        
        <div className="space-y-2">
          <div className="text-sm">
            <span className="text-gray-500">Current Task:</span>
            <p className="text-gray-300 mt-1">{agent.currentTask}</p>
          </div>
          <div className="text-xs text-gray-500">
            Last activity: {agent.lastActivity}
          </div>
        </div>
      </div>
      
      <div className={`absolute -right-10 -bottom-10 w-32 h-32 rounded-full blur-3xl opacity-20 group-hover:opacity-40 transition-all bg-${agent.color}-500`}></div>
    </div>
  );
}

function TaskBoard({ tasks }: { tasks: Task[] }) {
  const columns = ['inbox', 'in_progress', 'review', 'done'] as const;
  
  const columnNames = {
    inbox: 'Inbox',
    in_progress: 'In Progress',
    review: 'Review',
    done: 'Done'
  };

  const columnColors = {
    inbox: 'border-gray-700',
    in_progress: 'border-blue-500/50',
    review: 'border-amber-500/50',
    done: 'border-green-500/50'
  };

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
      {columns.map((column) => (
        <div key={column} className="bg-gray-900/50 rounded-xl p-4">
          <div className={`flex items-center justify-between mb-4 pb-2 border-b ${columnColors[column]}`}>
            <h3 className="font-semibold text-white">{columnNames[column]}</h3>
            <span className="text-gray-500 text-sm">
              {tasks.filter(t => t.status === column).length}
            </span>
          </div>
          <div className="space-y-3">
            {tasks.filter(t => t.status === column).map((task) => (
              <div key={task.id} className="bg-gray-800 rounded-lg p-3 hover:bg-gray-700 transition-colors cursor-pointer">
                <h4 className="text-sm font-medium text-white mb-1">{task.title}</h4>
                {task.description && (
                  <p className="text-xs text-gray-400">{task.description}</p>
                )}
                <div className="flex items-center gap-2 mt-2">
                  <span className={`text-xs px-2 py-1 rounded-full bg-${AGENTS.find(a => a.id === task.agentId)?.color}-900/30 text-${AGENTS.find(a => a.id === task.agentId)?.color}-400`}>
                    {AGENTS.find(a => a.id === task.agentId)?.name}
                  </span>
                </div>
              </div>
            ))}
          </div>
        </div>
      ))}
    </div>
  );
}

function ActivityFeed({ activities }: { activities: ActivityItem[] }) {
  const typeIcons = {
    task_started: <Clock className="w-4 h-4" />,
    task_completed: <CheckCircle2 className="w-4 h-4" />,
    message: <MessageSquare className="w-4 h-4" />,
    file_created: <FileText className="w-4 h-4" />
  };

  return (
    <div className="bg-gray-900 rounded-2xl p-6 border border-gray-800">
      <h3 className="text-lg font-bold text-white mb-4 flex items-center gap-2">
        <Activity className="w-5 h-5 text-green-400" />
        Activity Feed
      </h3>
      <div className="space-y-4 max-h-96 overflow-y-auto">
        {activities.map((activity) => (
          <div key={activity.id} className="flex items-start gap-3 pb-4 border-b border-gray-800 last:border-0">
            <div className="w-8 h-8 rounded-lg bg-gray-800 flex items-center justify-center text-gray-400">
              {typeIcons[activity.type]}
            </div>
            <div className="flex-1">
              <p className="text-sm text-white">
                <span className="font-semibold">{activity.agentName}</span>{' '}
                {activity.message}
              </p>
              <p className="text-xs text-gray-500 mt-1">{activity.timestamp}</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

// Main Page
export default function MissionControl() {
  const [agents] = useState<Agent[]>(AGENTS);
  const [tasks] = useState<Task[]>(TASKS);
  const [activities] = useState<ActivityItem[]>(ACTIVITIES);
  const [lastUpdated, setLastUpdated] = useState(new Date());

  const refreshData = () => {
    setLastUpdated(new Date());
    // In real implementation, this would fetch from Convex API
  };

  return (
    <div className="min-h-screen bg-gray-950 text-white p-8">
      <div className="max-w-7xl mx-auto">
        {/* Header */}
        <header className="mb-12">
          <div className="flex items-center justify-between">
            <div>
              <div className="inline-flex items-center gap-2 px-3 py-1 bg-green-900/30 border border-green-800 rounded-full text-green-400 text-xs font-bold uppercase tracking-wider mb-4">
                <Bot className="w-3 h-3" />
                AI Agent Squad
              </div>
              <h1 className="text-4xl md:text-5xl font-extrabold tracking-tight mb-4">
                <span className="bg-clip-text text-transparent bg-gradient-to-r from-white to-gray-500">
                  AWE2M8
                </span>{' '}
                <span className="bg-clip-text text-transparent bg-gradient-to-r from-green-400 to-emerald-600">
                  Mission Control
                </span>
              </h1>
              <p className="text-gray-400 text-lg max-w-2xl">
                Your AI agent squad working together. Track progress, assign tasks, and manage deliverables.
              </p>
            </div>
            <button 
              onClick={refreshData}
              className="flex items-center gap-2 px-4 py-2 bg-gray-900 border border-gray-800 rounded-lg hover:border-green-500/50 transition-all text-sm"
            >
              <RefreshCw className="w-4 h-4" />
              Refresh
            </button>
          </div>
          
          {/* Stats */}
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mt-8">
            <div className="bg-gray-900/50 border border-gray-800 rounded-xl p-4">
              <div className="text-2xl font-bold text-white">{agents.length}</div>
              <div className="text-sm text-gray-500">Active Agents</div>
            </div>
            <div className="bg-gray-900/50 border border-gray-800 rounded-xl p-4">
              <div className="text-2xl font-bold text-blue-400">{tasks.filter(t => t.status === 'in_progress').length}</div>
              <div className="text-sm text-gray-500">In Progress</div>
            </div>
            <div className="bg-gray-900/50 border border-gray-800 rounded-xl p-4">
              <div className="text-2xl font-bold text-green-400">{tasks.filter(t => t.status === 'done').length}</div>
              <div className="text-sm text-gray-500">Completed</div>
            </div>
            <div className="bg-gray-900/50 border border-gray-800 rounded-xl p-4">
              <div className="text-2xl font-bold text-amber-400">{activities.length}</div>
              <div className="text-sm text-gray-500">Activities Today</div>
            </div>
          </div>
        </header>

        {/* Agent Cards */}
        <section className="mb-12">
          <h2 className="text-xl font-bold text-white mb-6 flex items-center gap-2">
            <Users className="w-5 h-5 text-green-400" />
            Your Squad
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            {agents.map((agent) => (
              <AgentCard key={agent.id} agent={agent} />
            ))}
          </div>
        </section>

        {/* Task Board */}
        <section className="mb-12">
          <h2 className="text-xl font-bold text-white mb-6 flex items-center gap-2">
            <BarChart3 className="w-5 h-5 text-blue-400" />
            Task Board
          </h2>
          <TaskBoard tasks={tasks} />
        </section>

        {/* Activity Feed */}
        <section className="mb-12">
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <div className="lg:col-span-2">
              <ActivityFeed activities={activities} />
            </div>
            <div className="bg-gray-900 rounded-2xl p-6 border border-gray-800">
              <h3 className="text-lg font-bold text-white mb-4">Quick Actions</h3>
              <div className="space-y-3">
                <button className="w-full flex items-center justify-between p-3 bg-gray-800 rounded-lg hover:bg-gray-700 transition-colors text-left">
                  <span className="text-sm text-white">Assign New Task</span>
                  <ArrowRight className="w-4 h-4 text-gray-400" />
                </button>
                <button className="w-full flex items-center justify-between p-3 bg-gray-800 rounded-lg hover:bg-gray-700 transition-colors text-left">
                  <span className="text-sm text-white">View All Deliverables</span>
                  <ArrowRight className="w-4 h-4 text-gray-400" />
                </button>
                <button className="w-full flex items-center justify-between p-3 bg-gray-800 rounded-lg hover:bg-gray-700 transition-colors text-left">
                  <span className="text-sm text-white">Generate Daily Report</span>
                  <ArrowRight className="w-4 h-4 text-gray-400" />
                </button>
              </div>
              
              <div className="mt-6 pt-6 border-t border-gray-800">
                <h4 className="text-sm font-semibold text-gray-400 mb-2">Last Updated</h4>
                <p className="text-xs text-gray-500">{lastUpdated.toLocaleTimeString()}</p>
              </div>
            </div>
          </div>
        </section>

        {/* Footer */}
        <footer className="mt-16 pt-8 border-t border-gray-800 text-center text-gray-500 text-sm">
          <p>Mission Control v1.0 • AWE2M8 AI Squad • {new Date().getFullYear()}</p>
        </footer>
      </div>
    </div>
  );
}