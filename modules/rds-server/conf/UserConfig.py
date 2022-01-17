# Copyright (C) 2020 Advanced Media Workflow Association
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from . import Config as CONFIG

# Override default of multicast DNS to use unicast
CONFIG.DNS_SD_MODE = "unicast"

# Don't run a DNS Service - will use the one provided on the testbed
ENABLE_DNS_SD = False

#The location of the RDS Query API
QUERY_API_HOST = "10.0.50.77"
QUERY_API_PORT = 8010

#Our NMOS Test Bed DNS Domain
DNS_DOMAIN = "nmos-tb"

